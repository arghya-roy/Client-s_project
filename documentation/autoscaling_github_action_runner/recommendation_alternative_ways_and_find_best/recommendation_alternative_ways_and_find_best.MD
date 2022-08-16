## Recommendations for needed changes which would reduce cost and would improve the developer experience for Github action builder –
### Present cost – 
If we take billing for February month, then we can see that the cost is 
- approx 40 dollars for **three m5.large spot instances** if they are running for **700 hours** on average.
- 165 dollars for NATGateway 
- approx 40 dollars for Data Transfer. <br/>
Including other costs also the total cost is approx 250 dollars. 

### Ways to run Github action runner in autoscaling group - 
There are mainly 3 ways to run Github action runners in an autoscaling group in Amazon cloud services.
They are 
- Using on-demand EC2 in an autoscaling group and then create containers in those EC2 and run GitHub runner in those containers.
- Using EKS cluster and nodes and run GitHub runner in those pod/containers.
- Using spot instances in autoscaling mode and create containers in those instances and run GitHub runners in those containers ( which we are presently using ).

### Compare these ways as per cost perspective - 

#### Using on-demand EC2 in an autoscaling group and then create containers in those EC2 and run GitHub runner in those containers - 
As we discussed before that presently the cost of three spot instances running for 700 hours is approx 40 dollars. So instant of spot instances if we use on-demand instances then the price will be 4 to 5 times higher than spot instances because as per AWS **Amazon EC2 Spot Instances are spare capacity available at steep discounts compared to the EC2 On-Demand price, typically between 70% and 90% off.** So then the price will be -

- 0.096 * 3 * 700 = 200 dollars for instances.
- 165 dollars for NATGateway.
- Extra for data transfer. 
- others also. ( SNS, SQS, EBS etc ). <br/>
So it does not make any sense to use on-demand EC2 in autoscaling group. beacuse the cost will be more than 250 dollars which is our current cost.

#### Using EKS cluster and nodes and run GitHub runner in those pod/containers - 
In this cases we have to create a EKS Cluster and add nodes in this and use pod or containers in these nodes.
So if we use use EKS cluster then the price will be - 
- only for the cluster the price will be 0.10 dollar per hour. If we run this cluster for 700 hours theen the cost for cluster will be 70 dollars.
- 165 dollars for NATGateway.
- 0.096 * 3 * 700 = 200 dollars for instances ( nodes ).
- others also. <br/>
So for this case also the price will be much more higher than Spot instances in autoscaling mode.


#### Using spot instances in autoscaling mode and create containers in those instances and run GitHub runners in those containers - 
Now we are using spot instances in autoscaling mode and as compared to above two cases. spot instances in autoscaling mode is offering lower cost. The price is -
- 0.02 * 3 * 700 = 40 dollars for instances.
- 165 dollars for NATGateway.
- approx 40 dollars for data transfer. 
- others also. ( SNS, SQS, EBS etc ). <br/>
So as per cose perspective this is the best way.

### Compare these ways as per developer experience perspective -
Actually in the above three cases we are using github runner in container, So there will be no differences between those three cases as per developer exprience perspective.
as per developer exprience perspective all the three cases are same.

### If we keep both cost perspective and developer exprience perspective in our mind, then we can say that spot instances in autoscaling mode is best way to run github runners. And presently we are using this. So as per my opinion there is no change required.
