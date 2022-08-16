## Requirements for upgrade to drupal 9 from drupal 7 -
**PHP version** - 7.3 or higher but PHP 8 is recommended <br/>
**Apache version** - Apache 2.4.7 or higher. <br/>
**MySQL or Percona version** -  5.7.8+ <br/>
**MariaDB version** - 10.3.7 <br/>
**PostgreSQL version** - 10 with the pg_trgm extension. <br/>
**SQLite version** - 3.26 <br/>
**Aurora RDS Database version** - Amazon Aurora with MySQL compatibility + Serverless + Aurora (MySQL 5.7)

## What we have to change in our case?
1) We can use all Insfrastructure of Drupal 7 in Drupal 9. But we may update some of them, like - Aurora Database, solr, PHP.
2) All instance type of drupal 7 can be used for drupal 9.
3) Presently we are using  Aurora (MySQL 5.6). So now we have to update this to Aurora (MySQL 5.7).
4) We have to upgrade PHP to 8 or higher version. **( because PHP 8 compatibilies with solr 8 )
5) Search API Solr requires **Solr 8 or higher.**


## Referrences -
1) https://www.drupal.org/project/search_api_solr <br/>
2) https://citywebconsultants.co.uk/serverless-drupal-CI-CD-with-aws-fargate-and-aurora-rds/setup-aws-infrastructure#create-rds <br/>
3) https://www.drupal.org/project/drupal/releases/9.0.0#:~:text=Server%20and%20database%20requirements,MySQL%20or%20Percona%205.7 <br/>
4) https://www.drupal.org/docs/system-requirements/php-requirements#:~:text=Use%20PHP%20version%208.0%20or,10%20will%20require%20PHP%208.1 <br/>
5) https://solr.apache.org/downloads.html <br/>
6) https://docs.platform.sh/guides/drupal9/solr.html#:~:text=Search%20API%20Solr%20requires%20Solr,recommends%20Solr%208%20or%20higher.  ( 9th line line )
