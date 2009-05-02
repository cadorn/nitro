#/usr/bin/env bash

WORK=~/Workspace

EPRJ=$WORK/Jack # the gae project created in Eclipse
SKEL=$WORK/skel # the skeleton project dir
SAPP=$WORK/nitro/examples/simple # a simple app to use as starting point

WINF=$SKEL/war/WEB-INF

# To prepare the Skeleton project:
# 1. create a new Eclipse GAE Web application project with name 'Jack' and 
#    package 'org.jackjs' 
# 2. Set the servlet mapping path to '/*'.

cp -R $EPRJ $SKEL

# Link library files.

mkdir $WINF/narwhal
ln -s $WORK/narwhal/lib $WINF/narwhal/.
ln -s $WORK/narwhal/platforms $WINF/narwhal/.
ln -s $WORK/narwhal/narwhal.js $WINF/narwhal/.
ln -s $WORK/narwhal/narwhal.conf $WINF/narwhal/.
ln -s $WORK/narwhal/package.json $WINF/narwhal/.

# Copy packages

mkdir -p $WINF/narwhal/packages/jack
mkdir -p $WINF/narwhal/packages/nitro

ln -s $WORK/jack/lib $WINF/narwhal/packages/jack/.
ln -s $WORK/jack/package.json $WINF/narwhal/packages/jack/.

ln -s $WORK/nitro/lib $WINF/narwhal/packages/nitro/.
ln -s $WORK/nitro/package.json $WINF/narwhal/packages/nitro/.

rm $SKEL/src/org/jackjs/JackServlet.java
ln -s $WORK/jack-servlet/src/org/jackjs/JackServlet.java $SKEL/src/org/jackjs/.

# Remove unneeded files

rm $WINF/lib/datan*.jar
rm $WINF/lib/jdo*.jar
rm $SKEL/war/index.html
rm $SKEL/src/META-INF/jdoconfig.xml

# Link jars.

ln -s $WORK/narwhal/platforms/rhino/jars/js.jar $WINF/lib/.

# Copy simple app (use as starting point).

ln -s $SAPP/jackconfig.js $WINF/.
ln -s $SAPP/src $WINF/.

# Convienience root link.

pushd $WINF; ln -s .. root; popd

echo ""
echo "THE SKELETON IS READY"
echo ""
echo "1. Import '$SKEL' into Eclipse (File/Import/General/Existing Projects into Workspace)"
echo "2. Rename the project (Refactor/Rename)"
echo "3. Add the extra jars to the build path (js.jar, ..)"
