package main

import (
	"fmt"
	"log"
	"os"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/credentials"
	awsSession "github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/ec2"
)

var (
	accessKeyID = os.Getenv("AWS_ACCESS_KEY_ID")
	secretKey   = os.Getenv("AWS_SECRET_KEY")
)

func main() {
	config := aws.NewConfig().
		WithCredentials(credentials.NewStaticCredentials(accessKeyID, secretKey, ""))
	session, err := awsSession.NewSession(config)
	if err != nil {
		log.Printf("Couldnt make session; err: %s", err)
		os.Exit(1)
	}

	ec2Service := ec2.New(session)

	// func (c *EC2) DescribeInstances(input *DescribeInstancesInput) (*DescribeInstancesOutput, error)

	input := &ec2.DescribeInstancesInput{}
	output, err := ec2Service.DescribeInstances(input)
	if err != nil {
		log.Printf("Shit's broke yo: %s", err)
		os.Exit(32)
	}

	fmt.Printf("%s\n", output.GoString())
}
