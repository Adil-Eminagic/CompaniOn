
using CompaniOn.Core;
using CompaniOn.Core.Entities;
using Microsoft.EntityFrameworkCore;

namespace CompaniOn.Infrastructure
{
    public partial class DatabaseContext
    {
        private readonly DateTime _dateTime = new(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local);
        private readonly DateTime _dateTime_second = new(2023, 11, 1, 0, 0, 0, 0, DateTimeKind.Local);


        string image = "iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAM1BMVEXk5ueutLeqsbTn6eqpr7PJzc/j5ebf4eLZ3N2wtrnBxsjN0NLGysy6v8HT1tiss" +
            "ra8wMNxTKO9AAAFDklEQVR4nO2d3XqDIAxAlfivoO//tEOZ" +
            "WzvbVTEpic252W3PF0gAIcsyRVEURVEURVEURVEURVEURVEURVEURVEURVEURflgAFL/AirAqzXO9R7XNBVcy9TbuMHmxjN6lr92cNVVLKEurVfK/zCORVvW8iUBnC0" +
            "2dj+Wpu0z0Y6QlaN5phcwZqjkOkK5HZyPAjkIjSO4fIdfcOwFKkJlX4zPu7Ha1tIcwR3wWxyFhRG6g4Je0YpSPDJCV8a2Sv2zd1O1x/2WMDZCwljH+clRrHfWCLGK8REMiql//2si5+DKWKcWeAGcFMzzNrXC/0TUwQ2s6+Lhl" +
            "cwjTMlYsUIQzPOCb7YBiyHopyLXIEKPEkI/TgeuiidK/R9FniUDOjRDpvm0RhqjMyyXNjDhCfIMYl1gGjIMIuYsnGEYRMRZOMMunaLVwpWRW008v6fY" +
            "KDIzxCwVAeNSO90BJW6emelYBRF/kHpYGVaoxTDAaxOFsfP9y8hpJ4xd7gOcij7JNGQ1EYFgkPJa1jQEiYZXRaRINKxSDUW9n+FT82lSKadkiru9/4XPqSLWOekGPoY05TAvLm9orm+YWuwHoBHkZKijNBJGmeb61eL" +
            "6Ff/6q7bLr7yvv3vKGhpDRjvgjGaPz+gUg6YgcvpyAR2FIZ9U6nEEyZRTovmEU32KichpGn7C17XrfyH9gK/c0CMP05HZIM2uf9sEveizKveBy9/6Qt7o89ne33D525cfcIMW6ab+TMEukQbQbu+xu7X3A9bChmWaC" +
            "eAkG17bpntwXgWxHaMzGPmUaR5dQZiKqRVeUZ3047fi3nAu28h4CHxCsZAgmEH8Y27jJAhm8c+5RQzRQNVGhVFSfxOYIjp/pP7RxzjevYXVGf4eLt+BJ1vCuLuLkrgABgCGXZ2wik5uty+oBvNirI6mkzhAf4Gsb" +
            "58Hcm67Jzd+KwD10BYPLL3e0MjvKrgAULnOfveF/O4N2Xb9BZom3gJes3F9X5Zze8/6Yt09b4CrqsEjUv8oFBaR2rl+6CZr2xVrp24o/WitBKuGrrpl1+bFkmK2qXTON4VpbdfLa7o7y/WdLxG7lm2Lqh2clOwTeg" +
            "bvc/vj2U78CwhA87Bn8G5Nk3eOb0Nsr9flz3sG78UUtue4kpv1xvjg3TMay62BMl" +
            "TlP+vrOMnJsRmt/ze0jsfkPPYdAH57hK+34PeOyc8XIXu5xT2HsUkdZz+adwg8HGFfQ3K5jtDvbUiO4Di9/ywHGrL88pDizZ++oTp+an+SMX/ndymUCwmHMdO7yuOx83pUx/eEMU0AvxWndwgidAqOZ8ypCwdEfv" +
            "vEo6D9HwpA8wzvmOJEqAg9ySu8g4x0Hb9hSB/BANEKJ+LbPBU0lzbAJs4xt1AoshKkUGQmiH8/jJ0gdhTTLmSegHlPE0oOdXALnqDjKYh3px//fSgSWG8UqfrrIICzYYSJXRr9BSPbpNzw7gBjKjKOYI7ReIGqQRIap5" +
            "+5MdjyvuDkExvGeXSlONWZAP3/AZBwJohU7QJRGU+cTVH18ELmRPNBmibW6MT/k1b0XhdkRBvyT6SB6EYv/GvhSmRNpGngRULsAlxMCGNXp7w3FfdEbTEEDdLI9TdIKRUzUesa3I461ER8cpNT7gMRhpKmYVS9ELOgCU" +
            "Qsa4SsulciKiLbY+AnHD8cpuhISsnxpamI84sbDq9qYJgf8wiiOBrC7Ml7M7ZECCqKoiiKo" +
            "iiKoiiKoijv5AvJxlZRyNWWLwAAAABJRU5ErkJggg==";

        string image2 = "iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAM1BMVEXk5ueutLeqsbTn6eqpr7PJzc/j5ebf4eLZ3N2wtrnBxsjN0NLGysy6v8HT1tissra8wMNxTKO9AAAFDklEQVR4nO2d3XqDIAxAlfivoO//tEOZWzvbVTEpic252W3PF0gAIcsyRVEURVEURVEURVEURVEURVEURVEURVEURVEURflgAFL/AirAqzXO9R7XNBVcy9TbuMHmxjN6lr92cNVVLKEurVfK/zCORVvW8iUBnC0\r\n2djWpu0z0Y6QlaN5phcwZqjkOkK5HZyPAjkIjSO4fIdfcOwFKkJlX4zPu7Ha1tIcwR3wWxyFhRG6g4Je0YpSPDJCV8a2Sv2zd1O1x/2WMDZCwljHclRrHfWCLGK8REMiql//2si5DKWKcWeAGcFMzzNrXC/0TUwQ2s6Lhl\r\ncwjTMlYsUIQzPOCb7YBiyHopyLXIEKPEkI/TgeuiidK/R9FniUDOjRDpvm0RhqjMyyXNjDhCfIMYl1gGjIMIuYsnGEYRMRZOMMunaLVwpWRW008v6fY\r\nKDIzxCwVAeNSO90BJW6emelYBRF/kHpYGVaoxTDAaxOFsfP9y8hpJ4xd7gOcij7JNGQ1EYFgkPJa1jQEiYZXRaRINKxSDUW9nFT82lSKadkiru9/4XPqSLWOekGPoY05TAvLm9ormYWuwHoBHkZKijNBJGmeb61eL\r\n6Ff/6q7bLr7yvv3vKGhpDRjvgjGaPzgUg6YgcvpyAR2FIZ9U6nEEyZRTovmEU32KichpGn7C17XrfyH9gK/c0CMP05HZIM2uf9sEveizKveBy9/6Qt7o89ne33D525cfcIMW6abTMEukQbQbuxu7X3A9bChmWaC\r\neAkG17bpntwXgWxHaMzGPmUaR5dQZiKqRVeUZ3047fi3nAu28h4CHxCsZAgmEH8Y27jJAhm8c5RQzRQNVGhVFSfxOYIjp/pP7RxzjevYXVGf4eLtBJ1vCuLuLkrgABgCGXZ2wik5utyoBvNirI6mkzhAf4Gsb\r\n58Hcm67JzdKwD10BYPLL3e0MjvKrgAULnOfveF/O4N2Xb9BZom3gJes3F9X5Zze8/6Yt09b4CrqsEjUv8oFBaR2rl6CZr2xVrp24o/WitBKuGrrpl1bFkmK2qXTON4VpbdfLa7o7y/WdLxG7lm2Lqh2clOwTeg\r\nbvc/vj2U78CwhA87Bn8G5Nk3eOb0Nsr9flz3sG78UUtue4kpv1xvjg3TMay62BMl\r\nTlPvrOMnJsRmt/ze0jsfkPPYdAH57hK34PeOyc8XIXu5xT2HsUkdZzadwg8HGFfQ3K5jtDvbUiO4Di9/ywHGrL88pDizZoTpanSMX/ndymUCwmHMdO7yuOx83pUx/eEMU0AvxWndwgidAqOZ8ypCwdEfv\r\nvEo6D9HwpA8wzvmOJEqAg9ySu8g4x0Hb9hSB/BANEKJLbPBU0lzbAJs4xt1AoshKkUGQmiH8/jJ0gdhTTLmSegHlPE0oOdXALnqDjKYh3px//fSgSWG8UqfrrIICzYYSJXRr9BSPbpNzw7gBjKjKOYI7ReIGqQRIap5\r\n5MdjyvuDkExvGeXSlONWZAP3/AZBwJohU7QJRGUcTVH18ELmRPNBmibW6MT/k1b0XhdkRBvyT6SB6EYv/GvhSmRNpGngRULsAlxMCGNXp7w3FfdEbTEEDdLI9TdIKRUzUesa3I461ER8cpNT7gMRhpKmYVS9ELOgCU\r\nQsa4SsulciKiLbYAnHD8cpuhISsnxpamI84sbDq9qYJgf8wiiOBrC7Ml7M7ZECCqKoiiKo\r\niiKoiiKoijv5AvJxlZRyNWWLwAAAABJRU5ErkJggg==";

        private void SeedData(ModelBuilder modelBuilder)
        {
            SeedCountries(modelBuilder);
            SeedPhotos(modelBuilder);

            SeedUsers(modelBuilder);
            SeedGenders(modelBuilder);
            SeedRoles(modelBuilder);
        }

        private void SeedRoles(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Role>().HasData(
                  new()
                  {
                      Id = 1,
                      CreatedAt = _dateTime,
                      ModifiedAt = null,
                      Value = "Basic"

                  },
                  new()
                  {
                      Id = 2,
                      CreatedAt = _dateTime,
                      ModifiedAt = null,
                      Value = "Family"
                  });
        }

        private void SeedGenders(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Gender>().HasData(
                  new()
                  {
                      Id = 1,
                      CreatedAt = _dateTime,
                      ModifiedAt = null,
                      Value = "Male"

                  },
                  new()
                  {
                      Id = 2,
                      CreatedAt = _dateTime,
                      ModifiedAt = null,
                      Value = "Female"
                  },
                  new()
                  {
                      Id = 3,
                      CreatedAt = _dateTime,
                      ModifiedAt = null,
                      Value = "Non-binary"
                  },
                   new()
                   {
                       Id = 4,
                       CreatedAt = _dateTime,
                       ModifiedAt = null,
                       Value = "Other"
                   });
        }

        private void SeedPhotos(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Photo>().HasData(
                 new()
                 {
                     Id = 1,
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     Data = image

                 },
                 new()
                 {
                     Data = image,
                     Id = 2,
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                 });
        }

        private void SeedCountries(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Country>().HasData(
                new()
                {
                    Id = 1,
                    Name = "Bosnia and Herzegovina",
                    Abbreviation = "BIH",
                    IsActive = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new()
                {
                    Id = 2,
                    Name = "Croatia",
                    Abbreviation = "CRO",
                    IsActive = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new()
                {
                    Id = 3,
                    Name = "Serbia",
                    Abbreviation = "SRB",
                    IsActive = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new()
                {
                    Id = 4,
                    Name = "Montenegro",
                    Abbreviation = "MNE",
                    IsActive = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                });
        }

        private void SeedUsers(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>().HasData(
                 new()
                 {
                     Id = 1,
                     FirstName = "Site",
                     LastName = "Super Admin",
                     Email = "site.admin@gmail.com",
                     RoleId = 2,
                     GenderId = 1,
                     PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                     PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                     PhoneNumber = "38761123456",
                     BirthDate = new DateTime(1992, 4, 23),
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     CountryId = 1

                 },
                 new()
                 {
                     Id = 2,
                     FirstName = "Admin1",
                     LastName = "LatnameA1",
                     Email = "admin1@gmail.com",
                     RoleId = 2,
                     GenderId = 1,
                     PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                     PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                     PhoneNumber = "134146161",
                     BirthDate = new DateTime(1992, 4, 23),
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     CountryId = 1
                 },
                 new()
                 {
                     Id = 3,
                     FirstName = "User1",
                     LastName = "LastnameU1",
                     Email = "user1@gmail.com",
                     RoleId = 1,
                     GenderId = 1,
                     PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                     PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                     PhoneNumber = "4644644868",
                     BirthDate = new DateTime(1992, 4, 23),
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     CountryId = 1

                 },
                 new()
                 {
                     Id = 4,
                     FirstName = "User2",
                     LastName = "LastnameU2",
                     Email = "user2@gmail.com",
                     RoleId = 1,
                     GenderId = 1,
                     PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                     PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                     PhoneNumber = "4644644868",
                     BirthDate = new DateTime(1992, 4, 23),
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     CountryId = 1

                 },
                 new()
                 {
                     Id = 5,
                     FirstName = "User3",
                     LastName = "LastnameU3",
                     Email = "user3@gmail.com",
                     RoleId = 1,
                     GenderId = 2,
                     PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                     PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                     PhoneNumber = "4644644868",
                     BirthDate = new DateTime(1992, 4, 23),
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     CountryId = 1

                 },
                 new()
                 {
                     Id = 6,
                     FirstName = "User4",
                     LastName = "LastnameU4",
                     Email = "user4@gmail.com",
                     RoleId = 1,
                     GenderId = 2,
                     PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                     PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                     PhoneNumber = "4644644868",
                     BirthDate = new DateTime(1992, 4, 23),
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     CountryId = 1

                 },
                 new()
                 {
                     Id = 7,
                     FirstName = "User5",
                     LastName = "LastnameU5",
                     Email = "user5@gmail.com",
                     RoleId = 1,
                     GenderId = 1,
                     PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                     PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                     PhoneNumber = "4644644868",
                     BirthDate = new DateTime(1992, 4, 23),
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     CountryId = 1

                 });
        }

    }
}
