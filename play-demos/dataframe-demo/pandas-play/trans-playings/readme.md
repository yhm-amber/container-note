
# Pandas Data Frame transing in R

In python you are already did this: 

~~~ py
import pandas as pd
~~~

## Pickle

Same things in py and R: 

- Python: 
  
  ~~~ py
  df1 = pd.DataFrame({'A': [1,2,3], 'B': [4,3,2]})
  ~~~

- R: 
  
  ~~~ R
  df0 = data.frame(A = 1:3, B = 4:2)
  ~~~
  

### Demos

#### For `df1`

In Python: 

~~~ py
df1.to_pickle("df1.pkl") # to save
pd.read_pickle("df1.pkl") # to read again
~~~

In R: 

~~~ R
reticulate::py_load_object("df1.pkl") # to read

# read and save again
reticulate::py_load_object("df1.pkl") |> 
	reticulate::py_save_object("df1x.pkl")
~~~

#### For `df0`

In R: 

~~~ R
df0 |> reticulate::py_save_object("df0.pkl") # to save
reticulate::py_load_object("df0.pkl") # to read again
~~~

In Python: 

~~~ py
pd.read_pickle("df0.pkl") # to read

# read and save again
(pd.read_pickle("df0.pkl")
	.to_pickle("df0x.pkl"))
~~~




