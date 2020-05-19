#! /bin/bash
## Creates a small AWS EKS cluster.

help() {
    echo "To setup an AWS cluster, provide the following params."
    echo ""
    echo "#1 - AWS Profile to use."
    echo "I'm assuming you have set up a profile to use the AWS CLI."
    echo ""

    echo "#2 - Cluster name."
    echo "The name of the cluster."
    echo ""

    echo "#3 - Subnet Ids. Comma seperated. No spaces please! :-)"
    echo ""

    echo "#4 - Security Group Ids. Comma seperated. No spaces please! :-)"
    echo "Ensure there is network connectivity. I added a simple 0.0.0.0/0 for all traffic."
    echo ""

    echo "#5 - Cluster Role ARN."
    echo "Check https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html for more information."
    echo ""

    echo "#6 - Node Group Subnet Id."
    echo ""
    
    echo "#7 - Node Group Role ARN."
    echo "Check https://docs.aws.amazon.com/eks/latest/userguide/worker_node_IAM_role.html for more information."
    echo ""
}


echo ""
for arg in "$@"
do
    if [ "$arg" == "--help" ] || [ "$arg" == "-h" ] || [ "$arg" == "help" ] || [ "$arg" == "h" ]
    then
        help
        exit
    fi
done

echo "Bootstrapping EKS cluster."
echo ""
echo "Received the following args."
echo "AWS Profile: $1" 
echo "Cluster Name: $2"
echo "Cluster Subnet Ids: $3"
echo "Cluster Security Groups Ids: $4"
echo "Cluster Role ARN: $5"
echo "Node Group Subnet Id: $6"
echo "Node Group Role ARN: $7"
echo ""

echo "Creating cluster."
aws eks create-cluster \
    --profile $1 \
    --region eu-west-1 \
    --name $2 \
    --kubernetes-version 1.16 \
    --role-arn $5 \
    --resources-vpc-config subnetIds=$3,securityGroupIds=$4
echo ""
echo ""
echo ""

echo "Waiting for cluster to be active."
echo "This can take roughly 10 minutes."
aws eks wait cluster-active \
    --profile $1 \
    --region eu-west-1 \
    --name $2 
echo ""
echo "Cluster is active. Proceeding."
echo ""

echo "Creating node group for cluster."
aws eks create-nodegroup \
    --profile $1 \
    --region eu-west-1 \
    --cluster-name $2 \
    --nodegroup-name $2-nodegroup \
    --subnets $6 \
    --node-role $7 \
    --scaling-config minSize=1,maxSize=2,desiredSize=1
echo ""
echo ""
echo ""

echo "Waiting for node group to be active."
aws eks wait nodegroup-active \
    --profile $1 \
    --region eu-west-1 \
    --cluster-name $2 \
    --nodegroup-name $2-nodegroup 
echo ""
echo "Node group is active. Proceeding."
echo ""

echo "Updating your kubeconfig to point towards the newly created cluster."
aws eks update-kubeconfig \
    --profile $1 \
    --region eu-west-1 \
    --name $2 \
    --alias $2

echo ""
echo "Installing metrics server onto your newly deployed cluster."
echo ""
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml

echo "Finished execution."
echo "NOTE: EKS is not cheap. Ensure you're aware of your spending if you keep this running."