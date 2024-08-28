### Generating RSA Key Pair

To generate the RSA key pair, run the following command:

```bash
ssh-keygen -t rsa
```

Follow the prompts to save the key pair:

    Enter file in which to save the key (default: /home/vishal/.ssh/id_rsa): ./id_rsa
    Enter passphrase (empty for no passphrase): [leave blank or enter a passphrase]
    Enter same passphrase again: [repeat the passphrase if entered]

This will generate a private key : id_rsa & public key: id_rsa.pub in the current directory.