// Copyright (C) Tenacom and Contributors. Licensed under the MIT license.
// See the LICENSE file in the project root for full license information.

using System;
using System.Windows.Forms;

namespace SampleProject;

internal static class Program
{
    [STAThread]
    private static void Main()
    {
        // To customize application configuration such as set high DPI settings or default font,
        // see https://aka.ms/applicationconfiguration.
        ApplicationConfiguration.Initialize();

#pragma warning disable CA2000 // Dispose objects before losing scope - WinForms will take care of it
        Application.Run(new Form1());
#pragma warning restore CA2000 // Dispose objects before losing scope
    }
}
