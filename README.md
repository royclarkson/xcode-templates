Xcode Templates
===============

A Ruby shell script for generating custom Xcode templates

## Overview

Often when working with Xcode you may want to replace the default file heading with something else, maybe a license, or maybe more description about the project. This script will help you generate templates that are preconfigured with a specific heading, so you are no longer are required to copy and paste that information into your code. It copies the default templates from within the Xcode app bundle, then updates the header of each template with the specified license.

## Prerequisites

It is expected that you are on a Mac, running OS X, that you have the latest version of Xcode installed (7.1.1 as of this writing), and also are running Ruby 1.9.3 or newer.

## Usage

The script is executed from the command line, so the first step is to verify the script can be executed. Run the following command to make it executable.

```sh
chmod +x xctemplates.rb
```

Now you can simply run the script from your shell prompt. The default implementation generates templates with the Apache Software License (ASL) header.

```sh
./xctemplates.rb
```

You can also specify an alternate header file to use by passing a command line argument. The argument must match the name of a text file within the `templates` folder. Currently, only ASL, GPLv2 and MIT text files are provided.

```sh
./xctemplates.rb MIT
```

## Install the Templates

The templates are copied to the `staging` folder. Within that is a folder called `File Templates`. Use the following script to copy the generated `File Templates` folder and its contents into `~/Library/Developer/Xcode/Templates`:

```sh
./copy-templates.rb
```

Alternatively, you may use the following command:

```sh
cp -R staging ~/Library/Developer/Xcode/Templates
```

> **Note:** the script is capable of copying the generated templates into this location, but it is a limited implementation that simply erases any existing templates first. Since this is not always desirable, that functionality has been commented out until it can be improved.

## Delete the Templates

Use the following script to delete the contents from `~/Library/Developer/Xcode/Templates`:

```sh
./delete-templates.rb
```

## Use the Templates to Create a New File

When you select to add a new file you will see the new templates available as options within Xcode.

![<File Templates>](images/templates.png)

## Add New Header Files

This is very easy to do. Simply create a new text document in the `templates` folder with a descriptive name. For example you may want to use the BSD license, so create a `BSD.txt` and place it in the `templates` folder along side the ASL and MIT files. See the ASL and MIT files for inspiration. Once you have created a new file you can run the script, passing the name as a command line argument.

If you would like to share your header file with others, then feel free to submit a pull request and I will include it in the project.

## Contribute

I only invested a couple hours coding and manually testing this script. It does what I need it to do, but not much more. There are many areas for improvement and expansion, like tests! Pull requests are welcome.

## Copyright

Copyright (c) 2012-2015, Roy Clarkson. All Rights Reserved.

## License

Licensed under version 2.0 of the [Apache License](http://www.apache.org/licenses/LICENSE-2.0).
