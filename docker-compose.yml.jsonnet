local ddb = import 'ddb.docker.libjsonnet';

local domain = std.extVar('core.domain.value');
local dbConnectionString = 'postgresql://' + std.extVar('app.db.user') + ':' + std.extVar('app.db.password') + '@db/' + std.extVar('app.db.db');

ddb.Compose({
    services+: {
        db: ddb.Build('postgres') + ddb.User() +
          ddb.Binary('psql', '/project', 'psql --dbname=' + dbConnectionString) +
          ddb.Binary('pg_dump', '/project', 'pg_dump --dbname=' + dbConnectionString) +
          ddb.Expose('5432') + {
            environment+: {
              POSTGRES_USER: std.extVar('app.db.user'),
              POSTGRES_PASSWORD: std.extVar('app.db.password'),
              POSTGRES_DB: std.extVar('app.db.db'),
            },
            volumes+: [
              'db-data:/var/lib/postgresql/data',
              ddb.path.project + ':/project',
            ],
          },
        web: ddb.Build('web') + ddb.VirtualHost('80', domain)+ {
            volumes+: [
              ddb.path.project + '/public:/var/www/html',
            ],
        }
    }
})