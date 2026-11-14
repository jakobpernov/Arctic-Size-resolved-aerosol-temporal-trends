import numpy as np
import numpy.ma as ma
from netCDF4 import Dataset
import cartopy.crs as ccrs
import matplotlib.pyplot as plt
import cartopy.feature as cfeature
import pandas as pd
import cartopy
from matplotlib.image import imread
import os
import xarray as xr
import cmocean
import rasterio
from rasterio.windows import from_bounds, bounds as window_bounds



sice=xr.open_dataset('C:/Users/pernov/Documents/Trend Analysis/Arctic Stations/sic_psn25_202003_F17_v05r00.nc')

ice=sice.cdr_seaice_conc_monthly.isel(time=0).values

y=sice.y.values
x=sice.x.values

ice = ice.reshape(448, 304)

ice = ice / 250.

ice = ma.masked_greater(ice, 1.0)

dx = dy = 25000

x = np.arange(-3850000, +3750000, +dx)
y = np.arange(+5850000, -5350000, -dy)

x.shape, y.shape, ice.shape
extent = [-180, 180, 90, 64]
resolution = '50m'

Station_locations = (
                     ['Alert', 82.4991455078, -62.3415260315], \
                     ['Zeppelin', 78.90715, 11.88668], \
                     ['Villum', 81.600000, -16.666667], \
                     ['Pallas', 67.966667, 24.116667],
                     ['Värriö', 67.77, 29.58],
                    )
df = pd.DataFrame(Station_locations, columns = ['Station', 'lat', 'lon'])

#%% Figure
fig = plt.figure(figsize=(9, 9))
ax = plt.axes(projection=ccrs.NorthPolarStereo(central_longitude=0))

cs = ax.coastlines(resolution='10m', linewidth=0.5)

gls=ax.gridlines(crs=ccrs.PlateCarree(central_longitude=0), draw_labels=False,
                  linewidth=1, color='gray', alpha=0.35, linestyle='--',x_inline=False)

ax.set_extent([-180, 180, 60, 90], crs=ccrs.PlateCarree())

cmap=cmocean.tools.crop_by_percent(cmocean.cm.ice, 30, which='min', N=None)

kw = dict(central_latitude=90, central_longitude=-45, true_scale_latitude=70)
cs = ax.pcolormesh(x, y, ice, cmap=cmap,
                   transform=ccrs.Stereographic(**kw))

tif_path = r"C:\Users\pernov\Downloads\HYP_HR_SR_OB_DR\HYP_HR_SR_OB_DR.tif"

with rasterio.open(tif_path) as src:
    # crop to >=45N before reading - cuts data volume ~4x and avoids
    # wasting memory on the southern hemisphere you don't plot
    win = from_bounds(-180, 45, 180, 90, transform=src.transform)
    img = src.read([1, 2, 3], window=win)          # (3, rows, cols)
    img = np.moveaxis(img, 0, -1)                   # (rows, cols, 3), uint8
    left, bottom, right, top = window_bounds(win, src.transform)

ax.imshow(img, origin='upper',
          extent=[left, right, bottom, top],
          transform=ccrs.PlateCarree(),
          regrid_shape=2500,   # controls output resolution after reprojection
          zorder=0)

# Set extent of map and add gridlines
ax.set_extent(extent, ccrs.PlateCarree())


# --- Manually add latitude labels along longitude 0° ---
label_lon = 60  # where to place labels
latitudes = np.arange(65, 90, 5)  # which latitudes to label

for lat in latitudes:
    ax.text(label_lon, lat, f"{lat}°N",
            transform=ccrs.PlateCarree(),
            ha='left', va='center',
            fontsize=15, color='black',
            bbox=dict(facecolor='none', alpha=0.6, edgecolor='none', pad=1))

# Plot stations and station names
for index, row in df.iterrows():

    if row['Station'] == 'Villum': # Villum
        ax.text(row['lon']+2.5, row['lat']+1.9, str(row['Station']), size = 15,\
            bbox=dict(facecolor='white', fill='True', edgecolor='Black', boxstyle='round'), \
            transform=ccrs.PlateCarree())
        ax.plot(row['lon'], row['lat'], 's',color='dodgerblue',markeredgecolor='white', transform=ccrs.PlateCarree(), \
                        markersize = 15)
    
    elif row['Station'] == 'Zeppelin': #Zeppelin
        ax.text(row['lon']-10, row['lat']-2.5, str(row['Station']), size = 15,\
            bbox=dict(facecolor='white', fill='True', edgecolor='black', boxstyle='round'), \
            transform=ccrs.PlateCarree())
        ax.plot(row['lon'], row['lat'], '*', color=[0,0,0.80392],markeredgecolor='white', transform=ccrs.PlateCarree(), \
            markersize = 18)
        
    elif row['Station'] == 'Alert': #Alert
        ax.text(row['lon']+1.75, row['lat']+1.4, str(row['Station']), size = 15,\
            bbox=dict(facecolor='white', fill='False', edgecolor='black', boxstyle='round'), \
            transform=ccrs.PlateCarree())
        ax.plot(row['lon'], row['lat'], '^',color='dodgerblue',markeredgecolor='white', transform=ccrs.PlateCarree(), \
                        markersize = 15)
        
    elif row['Station'] == 'Pallas': #Pallas
        ax.text(row['lon']-12, row['lat']-1.45, str(row['Station']), size = 15, \
            bbox=dict(facecolor = 'white', fill='True', edgecolor='black', boxstyle='round'), \
            transform=ccrs.PlateCarree())
        ax.plot(row['lon'], row['lat'], 's',color=[0.27059,0.5451,0], markeredgecolor='white',transform=ccrs.PlateCarree(), \
                        markersize = 15)
        
    elif row['Station'] == 'Värriö': #Värriö
        ax.text(row['lon']+2, row['lat']+1.5, str(row['Station']), size = 15, \
                bbox=dict(facecolor = 'white', fill='True', edgecolor='black', boxstyle='round'), \
                transform=ccrs.PlateCarree())
        ax.plot(row['lon'], row['lat'], '^',color=[0.27059,0.5451,0],markeredgecolor='white', transform=ccrs.PlateCarree(), \
                        markersize = 15)
            
# plt.savefig('/data/users/jakob/arcticnap/figs/StationMap_PNSD_Trends_Stations.png',dpi=300)
# plt.show()


