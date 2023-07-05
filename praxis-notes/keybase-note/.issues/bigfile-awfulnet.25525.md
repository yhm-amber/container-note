site: https://github.com/keybase/client/issues/25525

# Big file will broke easily while copy it into KBFS with awful network

There is only two things happens: 

- (a big copying) You copy a *big* file into your `K:/public/xxx` or `/keybase/public/xxx`, then waiting ...
- (not not good) Your pc will have some tiny offline and that will make your `K:` or `/keybase` path unusable in some random minute or second

Then, the broken may happens.

I using windows explorer to copy this file, and I found that broken after the *two things* happened: 

- I see my copied big file in `K:/public/myname/somedir` have equal size with its origin file. But, this copied file is not complete the copy work, it have wrong content now, and it actually unusable ... it's a broken file 🤒.
- **And**, this wrong (broken) file is being uploading little by little 😧 !!! (if it is in `team` or `private` it will also be crypto ... 😫)
- I want to delete it manually 😦, but, you konw, now, my network is not so good, so maybe I can do this work one hour later ... But, this evil wrong file will may cost my network traffic to made its evil upload when the network become good and I don't know when it will happens 😩 ...

-----

Some way to solve this evil problem probably: 

- the size attribute need two: 
  
  - the correct size it should be (means record the size of origin file at its copy's metadata)
  - the real size it be copied (when two size is equal, the copy need to be hashed atleast once)
  
  then the work of copy is just append things into the aim file.
  
- and also need these 4 attributes: 
  
  - the `sha256` (or other hash) of the origin file (means record the hash of origin file at its copy's metadata)
  - does the hash complete (a boolean. when two size is equal, the hash begin.)
  - the timestamp of hash begin and complete (when the hash is begin and before its complete, append/change on this file is not be allowed)
  - the hash resault for the copied file (will not change)
  - does the file have new append/change after hash (boolean, equal with: `timestamp.lastchange > timestamp.hashcomplete`)
  
  then, if the hash of copy is not equal with its origin, by default, the crypto and upload should not be run, this will avoid the uploads of evil datas (broken files). 😃
  

The network can be awful at any time, so I think make the soft which work with net won't do wrong things very easy while the net became awful, is necessary.
  
