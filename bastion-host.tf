resource "aws_instance" "mcpatral-bastion" {
    ami = lookup(var.AMIS_REGION)
    instace_type = "t2.micro"
    key_name = file(var.Pubkey.key_name)
    subnet_id =module.vpc.public_subnets[0]
    count = var.instance_count
    vpc_security_group_ids = [aws_security_group.mcpatral-bastion-sg-id]
    tags = {
        name="mcpatral-bastion"
        project = "mcpatral"
    }
    provisioner "file" {
        content =templatefile("db_deploy.tmpl", {rds-endpoint = aws_db_instance.mcpatral-rds.address, dbuser =var.dbuser, dbpass = var.db_pass })
        destination = "/tmp/mcpatral-dbdeploy.sh"
    }
    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/mcpatral-deploy.sh",
            "sudo /tmp/mcpatral-dbdeploy.sh"
        ]
    }
    connection {
        user =var.username
        PrivKey = file(var.PrivKey)
        host =self.public_ip 
    }
    depend_on = [awss_db_instance.mcpatral-rds]
}