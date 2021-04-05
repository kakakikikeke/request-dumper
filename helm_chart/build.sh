VERSION=`grep 'version:' ./request-dumper/Chart.yaml | cut -d' ' -f2`
cp ../README.md ./request-dumper/
helm package ./request-dumper
mv request-dumper-${VERSION}.tgz ../docs
helm repo index ../docs --url http://kakakikikeke.github.io/request-dumper
rm ./request-dumper/README.md
