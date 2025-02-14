let 
  user1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOg2VKzAytPvs9aArki7JPDyOLjn6+/soebm7JJdNQ5x martin@Lok";
  users = [ user1 ];

  server1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ64hmKzG5GEqcGotpLkqDmpKXY0puOxrTHNkU/IhJ2f root@nixos";
  vm = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIInPDl967NTSJ1YZcYSrl6I8iucTK7Chi5lf40amwdX9 root@nixos ";
  systems = [ server1 vm ];

in
{
  "pia-credentials.age".publicKeys = systems ++ users;
  "user-password.age".publicKeys = systems ++ users;
  "caddy-basicauth.age".publicKeys = [ server1 ];
  "cloudflare.age".publicKeys = systems ++ users;
  "test.age".publicKeys = systems ++ users;
}
