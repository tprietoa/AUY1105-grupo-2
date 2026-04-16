package terraform.policies

import future.keywords.if

deny_ssh_public if {
    some i
    resource := input.resource_changes[i]
    resource.type == "aws_security_group"
    
    ingress := resource.change.after.ingress[_]
    ingress.from_port == 22
    
    ingress.cidr_blocks[_] == "0.0.0.0/0"
}


deny_wrong_instance_type if {
    some i
    resource := input.resource_changes[i]
    resource.type == "aws_instance"
    
    resource.change.after.instance_type != "t2.micro"
}
