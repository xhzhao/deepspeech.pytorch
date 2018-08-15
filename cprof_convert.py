import cProfile
import pstats
p = pstats.Stats('output.pstats')
p.sort_stats('tottime').print_stats()
