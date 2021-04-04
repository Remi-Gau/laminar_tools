# laminar analysis tools

## Dependencies

You will need Matlab or Octave and SPM12 to make use of this code.

| Matlab, toolbox and other dependencies                   | Used version |
| -------------------------------------------------------- | ------------ |
| [Matlab](https://www.mathworks.com/products/matlab.html) | 2016a        |
| SPM12                                                    | v6685        |

Other functions from github and the mathwork file exchange are needed. All of
them are shipped with this repo in the `lib` folder or can be pulled from github
as submodules.

So to install all the code and its dependencies you simply to run:

```
git clone --recurse-submodules https://github.com/Remi-Gau/laminar_tools.git
```

## Set up

When in the root folder simply run `InitLaminarTools` from the Matlab / Octave
prompt to add all relevant folders to the matlab path.

### Settings

Most settings can be changes in m files in the following folder:

```
lib/laminar_tools/src/settings
```

## Easiest way to start

Check the `demos` folder
