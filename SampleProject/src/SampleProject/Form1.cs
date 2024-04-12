// Copyright (C) Tenacom and Contributors. Licensed under the MIT license.
// See the LICENSE file in the project root for full license information.

using System.Globalization;
using System.Windows.Forms;
using SampleProject.Library;

namespace SampleProject;

public partial class Form1 : Form
{
    public Form1()
    {
        InitializeComponent();

        lblTheAnswer.Text = MagicUtility.GetTheAnswer().ToString(CultureInfo.InvariantCulture);
    }
}
