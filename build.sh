
COMMIT=$(git rev-parse HEAD | cut -c-8)
NEW_VERSION=3.4.0-coveo-$COMMIT

sed -i "s/<Xlint:-unchecked\/>//" ./hadoop-project/pom.xml
mvn versions:set -DnewVersion="$NEW_VERSION"

sed -i "s/<hadoop.version>\(.*\)<\/hadoop.version>/<hadoop.version>$NEW_VERSION<\/hadoop.version>/" pom.xml
sed -i "s/<Xlint\/>/<Xlint\/><Xlint:-unchecked\/>/" ./hadoop-project/pom.xml

DEPLOY_CMD="mvn -U deploy -DskipTests"

mvn -U clean install -DskipTests
(cd hadoop-project && $DEPLOY_CMD)
(cd hadoop-project-dist && $DEPLOY_CMD)
(cd hadoop-assemblies  && $DEPLOY_CMD)
(cd hadoop-maven-plugins  && $DEPLOY_CMD)
(cd hadoop-common-project && $DEPLOY_CMD)
(cd hadoop-hdfs-project  && $DEPLOY_CMD)
(cd hadoop-mapreduce-project  && $DEPLOY_CMD)
(cd hadoop-client-modules && $DEPLOY_CMD)
(cd hadoop-tools/hadoop-aws  && $DEPLOY_CMD)
