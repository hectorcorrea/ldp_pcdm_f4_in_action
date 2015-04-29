These are the CURL commands that I ran when following Andrew Woods excellent "LDP-PCDM-F4 In Action" tutorial at https://wiki.duraspace.org/display/FEDORA4x/LDP-PCDM-F4+In+Action


These commands assume that Fedora 4 is running at the default location that Hydra Jetty configures and with authentication enabled (which is why the default username/password are being passed on the URL)

    http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/



# /objects/
Create our root node /objects/

    curl -i -XPUT -H"Content-Type: text/turtle" --data-binary @pcdm-object.ttl "http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/"


# /objects/raven/
Create the /objects/raven/ object

    curl -i -XPUT -H"Content-Type: text/turtle" --data-binary @pcdm-object.ttl "http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/"


# /objects/raven/pages 
Create a direct container /objects/raven/pages

    curl -i -XPUT -H"Content-Type: text/turtle" --data-binary @ldp-direct.ttl "http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/"

Add three pages (cover, page0, and page1) to the /objects/raven/pages direct container

    curl -i -XPUT -H"Content-Type: text/turtle" --data-binary @pcdm-object.ttl "http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/cover/"
    curl -i -XPUT -H"Content-Type: text/turtle" --data-binary @pcdm-object.ttl "http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/page0/"
    curl -i -XPUT -H"Content-Type: text/turtle" --data-binary @pcdm-object.ttl "http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/page1/"


# /objects/raven/pages/cover/files
Create a direct container /objects/raven/pages/cover/files

    curl -i -XPUT -H"Content-Type: text/turtle" --data-binary @ldp-cover-direct.ttl "http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/cover/files/"

add a file to /objects/raven/pages/cover/files

    curl -i -XPUT -H"Content-Type: image/jpeg" --data-binary @chicago.jpg "http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/cover/files/cover.jpg"
    curl -I http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/cover/files/cover.jpg
    curl -i -XPATCH -H"Content-Type: application/sparql-update" --data-binary @pcdm-file.ru http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/cover/files/cover.jpg/fcr:metadata

add another file to /objects/raven/pages/cover/files

    curl -i -XPUT -H"Content-Type: image/tiff" --data-binary @chicago.tif "http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/cover/files/cover.tif"
    curl -i -XPATCH -H"Content-Type: application/sparql-update" --data-binary @pcdm-file.ru http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/cover/files/cover.tif/fcr:metadata


# /objects/raven/pages/page0/files
Create a direct container /objects/raven/pages/page0/files 
(I had to use filesX instead of files since I goofed the first time around)

    curl -i -XPUT -H"Content-Type: text/turtle" --data-binary @ldp-page0-direct.ttl "http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/page0/filesX/"

add a file to /objects/raven/pages/page0/files

    curl -i -XPUT -H"Content-Type: image/jpeg" --data-binary @horse.jpg "http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/page0/filesX/horse.jpg"
    curl -i -XPATCH -H"Content-Type: application/sparql-update" --data-binary @pcdm-file.ru http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/page0/filesX/horse.jpg/fcr:metadata

add another file to /objects/raven/pages/page0/files

    curl -i -XPUT -H"Content-Type: image/tiff" --data-binary @horse.tif "http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/page0/filesX/horse.tif"
    curl -i -XPATCH -H"Content-Type: application/sparql-update" --data-binary @pcdm-file.ru http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/page0/filesX/horse.tif/fcr:metadata


# /objects/raven/pages/page1/files
Create a direct container /objects/raven/pages/page1/files

    curl -i -XPUT -H"Content-Type: text/turtle" --data-binary @ldp-page1-direct.ttl "http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/page1/files/"

add a file to/objects/raven/pages/page1/files

    curl -i -XPUT -H"Content-Type: image/jpeg" --data-binary @building.jpg "http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/page1/files/building.jpg"
    curl -i -XPATCH -H"Content-Type: application/sparql-update" --data-binary @pcdm-file.ru http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/page1/files/building.jpg/fcr:metadata

add another file to /objects/raven/pages/page1/files

    curl -i -XPUT -H"Content-Type: image/tiff" --data-binary @building.tif "http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/page1/files/building.tif"
    curl -i -XPATCH -H"Content-Type: application/sparql-update" --data-binary @pcdm-file.ru http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/objects/raven/pages/page1/files/building.tif/fcr:metadata


# /collections
Create our root node /collections/

    curl -i -XPUT -H"Content-Type: text/turtle" --data-binary @pcdm-object.ttl "http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/collections"

and add a poe collection inside of it

    curl -i -XPUT -H"Content-Type: text/turtle" --data-binary @pcdm-object.ttl "http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/collections/poe"

and add an indirect container inside the poe collection

    curl -i -XPUT -H"Content-Type: text/turtle" --data-binary @ldp-indirect.ttl "http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/collections/poe/members/"

and now add a child to this indirect container

  curl -i -XPUT -H"Content-Type: text/turtle" --data-binary @pcdm-raven-proxy.ttl "http://fedoraAdmin:fedoraAdmin@localhost:8983/fedora/rest/collections/poe/members/ravenProxy"





