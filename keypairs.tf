resource "aws_key_pair" "mcpatral" {
  key_name   = "mcpatral"
  public_key = file(var.Pubkey)
}