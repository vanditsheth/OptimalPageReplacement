OptimalPageReplacement
======================

Optimal Page Replacement algorithm simulated in MATLAB.

Optimal page replacement algorithm is only possible if we have a batch system i.e. the order of page calls is known before-hand. Here the locality of reference has been taken into consideration. The number of page calls are 2000 whereas the number of logical pages are 2000 and the physical pages range from 1 to 20(the number of logical pages). In OPR the page when there is a page fault, first the empty slots (having page number 0) are filled. If there is no such slot than the page that is referenced again after maximum cycles is replaced. This algorithm is best to avoid page faults but it is expensive as the next reference of all physical pages will have to be checked. Also, this is only realizable if we know the sequence of page references before-hand.

