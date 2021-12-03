Remember to modify URL before running load test.

GET load test: 
> tsung -f GET_RedCup_tsung.xml -k start

POST load test: 
> tsung -f POST_RedCup_tsung.xml -k start

Mixture load test:
  for version without S3 optimization & with S3 proxy optimization: 
  > tsung -f Mixture_withuploadfile_RedCup_tsung.xml -k start
  (directly upload files through tsung)

  for version with S3 client optimization: 
  > tsung -f Mixture_withuploadS3_RedCup_tsung.xml -k start
  (send link through tsung)

Plot:
  tsplot config file: ./http.plots.en.conf
  tsplot -c ./http.plots.en.conf -d <output_path> <old_name> tsung_logs/<old_time>/tsung.log <new_name> tsung_logs/<new_time>/tsung.log