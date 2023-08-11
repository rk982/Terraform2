resource "aws_key_pair" "tfkeypair"{
    key_name = "tfkeypair"
    public_key = tls_private_key.rsa.public_key_openssh

}
 
resource "tls_private_key" "rsa" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "local_file" "tfkeypair" {
    content = tls_private_key.rsa.private_key_pem
    filename = "terrakeyssh"
}

resource "aws_instance" "teravm1" {
    ami = "${lookup(var.AMIS,var.AWS_REGION)}"
    instance_type = "t2.micro"
    key_name = "tfkeypair"
    vpc_security_group_ids = ["${aws_security_group.simply_sg.id}"]
    subnet_id = "${aws_subnet.main_public_1.id}"
    #security_groups =  [aws_security_group.simply_sg.tf_sg]
   # subnet_id = [aws_subnet.main_public_1.id]
    
}