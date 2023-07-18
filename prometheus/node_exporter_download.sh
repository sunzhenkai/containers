DEST_FILE=/tmp/prometheus_node_exporter.tar.gz
DEST_INSTALL=/data/app
VERSION=1.6.1
SRC=https://github.com/prometheus/node_exporter/releases/download/v$VERSION/node_exporter-$VERSION.linux-amd64.tar.gz

wget $SRC -O $DEST_FILE
[ ! -e $DEST_INSTALL ] && mkdir $DEST_INSTALL
tar -xf $DEST_FILE -C $DEST_INSTALL
mv $DEST_INSTALL/node_exporter-$VERSION.linux-amd64 $DEST_INSTALL/node_exporter-$VERSION.linux-amd64