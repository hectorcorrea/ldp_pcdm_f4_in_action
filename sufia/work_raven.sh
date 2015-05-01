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
curl -i -XPUT -H "Content-Type: text/turtle" --data-binary @works.ttl $BASE/works/

# Add one work (raven)
curl -i -XPUT -H "Content-Type: text/turtle" --data-binary @raven.ttl $BASE/works/raven/

# ...and a direct container to hold the files of the work 
curl -i -XPUT -H "Content-Type: text/turtle" --data-binary @raven-genfiles.ttl $BASE/works/raven/genfiles


# Add an object to represent the file (this is the Sufia GenericFile)
# This is not the actual file, this is a pcdm:Object
# This object has descriptive metadata (e.g. dc:title)
curl -i -XPUT -H "Content-Type: text/turtle" --data-binary @cover.ttl $BASE/works/raven/genfiles/cover.jpg

# Add a direct container to hold the actual files for the generic file
curl -i -XPUT -H "Content-Type: text/turtle" --data-binary @cover-files.ttl $BASE/works/raven/genfiles/cover.jpg/files

# Add an actual file to the GenericFile (cover.jpg) via the direct container (cover.jpg/files)
# These objects should pcdm:File (todo: add extra curl call to patch them)
# These objects do NOT have descriptive metadata
curl -i -XPUT -H "Content-Type: image/jpeg"  --data-binary @cover.jpg $BASE/works/raven/genfiles/cover.jpg/files/content
curl -i -XPUT -H "Content-Type: image/jpeg"  --data-binary @cover_thumb.jpg $BASE/works/raven/genfiles/cover.jpg/files/thumbnail


# Add an object represent another file inside the work (again, this is a Sufia GenericFile)
# This is not the actual file, this is a pcdm:Object
# And will have descriptive metadata
curl -i -XPUT -H "Content-Type: text/turtle" --data-binary @raven-pdf.ttl $BASE/works/raven/genfiles/raven.pdf

# Add a direct container to hold the actual files for the generic file
curl -i -XPUT -H "Content-Type: text/turtle" --data-binary @raven-pdf-files.ttl $BASE/works/raven/genfiles/raven.pdf/files

# Add three files to the GenericFile (raven.pdf) via the direct container (raven.pdf/files)
curl -i -XPUT -H "Content-Type: application/pdf"  --data-binary @raven.pdf $BASE/works/raven/genfiles/raven.pdf/files/content
curl -i -XPUT -H "Content-Type: image/png"        --data-binary @raven_thumb.png $BASE/works/raven/genfiles/raven.pdf/files/thumbnail
curl -i -XPUT -H "Content-Type: text/plain"       --data-binary @raven.txt $BASE/works/raven/genfiles/raven.pdf/files/text


#
# COLLECTIONS
#
# Collection root
curl -i -XPUT -H "Content-Type: text/turtle" --data-binary @collections.ttl $BASE/collections/

# Add one collection (poe)
curl -i -XPUT -H "Content-Type: text/turtle" --data-binary @poe.ttl $BASE/collections/poe

# Add an indirect container to help with adding existing works to the collection
curl -i -XPUT -H "Content-Type: text/turtle" --data-binary @poe-members.ttl $BASE/collections/poe/members

# Add the Raven work to the Poe collection
curl -i -XPUT -H "Content-Type: text/turtle" --data-binary @raven-proxy.ttl $BASE/collections/poe/members/ravenProxy
