let 
  user1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOg2VKzAytPvs9aArki7JPDyOLjn6+/soebm7JJdNQ5x martin@Lok";
  users = [ user1 ];

  server1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ64hmKzG5GEqcGotpLkqDmpKXY0puOxrTHNkU/IhJ2f root@nixos";
  systems = [ server1 ];

in
{
  "user-password.age".publicKeys = systems ++ users;
  "caddy-basicauth.age".publicKeys = [ server1 ];
  "cloudflare.age".publicKeys = systems ++ users;
  "test.age".publicKeys = systems ++ users;
}
