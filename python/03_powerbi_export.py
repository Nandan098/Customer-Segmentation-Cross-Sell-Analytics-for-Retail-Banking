from pathlib import Path
import pandas as pd
pd.read_csv(Path("../outputs/customer_segments_powerbi.csv")).to_csv(Path("../powerbi/customer_segments_powerbi.csv"),index=False)
