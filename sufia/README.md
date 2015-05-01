# PCDM in Sufia with Fedora 4
This is an attempt to map the example described in [LDP-PCDM-F4 In Action](https://wiki.duraspace.org/display/FEDORA4x/LDP-PCDM-F4+In+Action) to the classes that we will have in Sufia. 

These are the two base diagrams that I am using for this mapping:
* [Sufia PCDM](https://docs.google.com/drawings/d/1uTbg0FPQDoa2zN6p1I37m-M3CFnlx85Mp9CEyRw-rf4/edit)
* [Fedora PCDM](https://wiki.duraspace.org/download/attachments/68067286/ldp-pcdm-f4-dirs.png?version=2&modificationDate=1428639700927&api=v2)

LDP-PCDM-F4 in Action uses the example of a work "Raven" with a few files, that is associated to the "Poe" collection. For the purposes of the mapping to Sufia I am using "genfiles" instead of "pages". I am also using two different kind of files (cover.jpg and raven.pdf) to show that different kind of derivatives will be saved for each file depending on their type.

    LDP  Fedora URI                                       Sufia class         Hydra::PCDM class      
    ---  -----------------------------------------------  ------------------  -----------------   
    BC   /works                
    BC   /works/raven                                     Sufia::Work         PCDM::Object    
    DC   /works/raven/genfiles                            [1]                
                
    BC   /works/raven/genfiles/cover.jpg                  Sufia::GenericFile  PCDM::Object    
    DC   /works/raven/genfiles/cover.jpg/files            [1]                
    NR   /works/raven/genfiles/cover.jpg/files/content    Sufia::File         PCDM::File      
    NR   /works/raven/genfiles/cover.jpg/files/thumbnail  Sufia::File         PCDM::File      
                    
    BC   /works/raven/genfiles/raven.pdf                  Sufia::Work         PCDM::Object    
    DC   /works/raven/genfiles/raven.pdf/files            [1]                
    NR   /works/raven/genfiles/raven.pdf/files/content    Sufia::File         PCDM::File      
    NR   /works/raven/genfiles/raven.pdf/files/thumbnail  Sufia::File         PCDM::File      
    NR   /works/raven/genfiles/raven.pdf/files/text       Sufia::File         PCDM::File      
    
    BC   /collections
    BC   /collections/poe                                 Sufia:Collections   PCDM::Collection
    IC   /collections/poe/members
    RS   /collections/poe/members/ravenProxy


**Question:** Will the Direct and Indirect containers have a mapping to Ruby classes or will their existence be handled behing the scenes by Active Fedora?


Fetching `/works/raven` will return 

    </works/raven> pcdm:hasMember </works/raven/genfiles/cover.jpg> .
    </works/raven> pcdm:hasMember </works/raven/genfiles/raven.pdf> .

Fetching `/works/raven/genfiles/cover.jpg` will return 

    </works/raven/genfiles/cover.jpg> pcdm:hasFile </works/raven/genfiles/cover.jpg/files/content> .
    </works/raven/genfiles/cover.jpg> pcdm:hasFile </works/raven/genfiles/cover.jpg/files/thumbnail> .
    
Fetching `/collections/poe` will return

    </collections/poe> pcdm:hasMember </works/raven> .
    

Key for the LDP column (remember that all containers are also RDF sources)
* BC: Basic Container
* DC: Direct Container
* IC: Indirect Container
* NR: Non-RDF Source
* RS: RDF Source

You should also take a look at Adam Wead's [examples](https://github.com/awead/sufia-pcdm) on this topic.


# Run the sample in Fedora 4 
Run `work_raven.sh` to create these objects in Fedora 4.
