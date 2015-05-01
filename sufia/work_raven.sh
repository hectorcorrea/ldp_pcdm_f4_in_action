#!/bin/bash

BASE="http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/pcdm"


# Reset
curl -X DELETE ${BASE}
curl -X DELETE ${BASE}/fcr:tombstone
curl -X PUT ${BASE}


# 
# WORKS
# 

# Works root
curl -i -XPUT -H    "Content-Type: text/turtle" --data-binary @works.ttl $BASE/works/

# One work (raven)
curl -i -XPUT -H    "Content-Type: text/turtle" --data-binary @raven.ttl $BASE/works/raven/

# Add a direct container to hold the files for the work 
curl -i -XPUT -H    "Content-Type: text/turtle" --data-binary @raven-genfiles.ttl $BASE/works/raven/genfiles

# Add an object to represent the file (this is the Sufia GenericFile)
# This is not the actual file, this is a pcdm:Object
curl -i -XPUT -H    "Content-Type: text/turtle" --data-binary @cover.ttl $BASE/works/raven/genfiles/cover.jpg

# Add a direct container to hold the actual files for the generic file
curl -i -XPUT -H    "Content-Type: text/turtle" --data-binary @cover-files.ttl $BASE/works/raven/genfiles/cover.jpg/files

# Add an actual file to the GenericFile (cover.jpg) via the direct container (cover.jpg/files)
curl -i -XPUT -H    "Content-Type: image/jpeg"  --data-binary @cover.jpg $BASE/works/raven/genfiles/cover.jpg/files/content
# TODO: add thumbnail for file $BASE/works/raven/genfiles/cover.jpg/files/thumbnail

# TODO: add a second file $BASE/works/raven/genfiles/firstedition.pdf/files/content
# TODO: add a second file $BASE/works/raven/genfiles/firstedition.pdf/files/thumbnail


