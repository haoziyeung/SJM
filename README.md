SJM, Cloned from [SJM](https://github.com/StanfordBioinformatics/SJM) with the following modifications
1. remove boost dependency, use embeded [CLI](https://github.com/CLIUtils/CLI11) instead
2. remove TCLAP dependency, use std::regex instead
3. remove perl scripts run_with_env, keep perl scripts away
4. allow compile and executaion under environment without sge/lfs
5. support local job submit and monitoring natively if no sge/lfs found

Installation && usage
1. clone repo
   `git clone https://github.com/vanNul/SJM.git`
2. compile
   `cd SJM`
   `./autogen.sh`
   `./configure --prefix=/path/to/install/dir/`
   `make`
   `make install`
3. usage

 3.1 simple usage  
       prepare a sjm jobfile such as [example.sjm](https://github.com/vanNul/SJM/tree/master/doc/example.sjm) and run
      `sjm example.sjm`  

 3.2 advanced usage  
      implement a pipeline based on sjm with various control, eg. [anapipe](https://github.com/vanNul/anapipe)
  you'd better check [manual](https://github.com/vanNul/SJM/tree/master/doc/MANUAL.txt) for more help  

 3.3 visualizing the DAG of jobs  

* `sjm -r doc/example.sjm > doc/example.dot`
* `perl doc/convert_sjmDAG_2_stdDAG.pl doc/example.dot|dot -Tpng > doc/example.png` (you need install [graphviz](http://www.graphviz.org/) package)

![doc/example.png](https://github.com/haoziyeung/supp_files/raw/master/example.png)
