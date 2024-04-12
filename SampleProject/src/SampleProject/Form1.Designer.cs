namespace SampleProject;

partial class Form1
{
    /// <summary>
    ///  Required designer variable.
    /// </summary>
    private System.ComponentModel.IContainer components = null;

    /// <summary>
    ///  Clean up any resources being used.
    /// </summary>
    /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
    protected override void Dispose(bool disposing)
    {
        if (disposing && (components != null))
        {
            components.Dispose();
        }
        base.Dispose(disposing);
    }

    #region Windows Form Designer generated code

    /// <summary>
    ///  Required method for Designer support - do not modify
    ///  the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
        tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
        lblTheAnswer = new System.Windows.Forms.Label();
        tableLayoutPanel1.SuspendLayout();
        SuspendLayout();
        // 
        // tableLayoutPanel1
        // 
        tableLayoutPanel1.ColumnCount = 3;
        tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
        tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle());
        tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
        tableLayoutPanel1.Controls.Add(lblTheAnswer, 1, 1);
        tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
        tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
        tableLayoutPanel1.Margin = new System.Windows.Forms.Padding(13);
        tableLayoutPanel1.Name = "tableLayoutPanel1";
        tableLayoutPanel1.RowCount = 3;
        tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
        tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle());
        tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
        tableLayoutPanel1.Size = new System.Drawing.Size(466, 411);
        tableLayoutPanel1.TabIndex = 0;
        // 
        // lblTheAnswer
        // 
        lblTheAnswer.AutoSize = true;
        lblTheAnswer.Location = new System.Drawing.Point(192, 173);
        lblTheAnswer.Margin = new System.Windows.Forms.Padding(9, 8, 9, 8);
        lblTheAnswer.Name = "lblTheAnswer";
        lblTheAnswer.Size = new System.Drawing.Size(82, 65);
        lblTheAnswer.TabIndex = 0;
        lblTheAnswer.Text = "xx";
        lblTheAnswer.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
        lblTheAnswer.UseMnemonic = false;
        // 
        // Form1
        // 
        AutoScaleDimensions = new System.Drawing.SizeF(96F, 96F);
        AutoScaleMode = System.Windows.Forms.AutoScaleMode.Dpi;
        ClientSize = new System.Drawing.Size(466, 411);
        Controls.Add(tableLayoutPanel1);
        Font = new System.Drawing.Font("Segoe UI", 36F, System.Drawing.FontStyle.Bold);
        FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
        Margin = new System.Windows.Forms.Padding(13);
        MaximizeBox = false;
        MaximumSize = new System.Drawing.Size(643, 600);
        MinimizeBox = false;
        MinimumSize = new System.Drawing.Size(321, 300);
        Name = "Form1";
        ShowIcon = false;
        StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
        Text = "...And the answer is...";
        TopMost = true;
        tableLayoutPanel1.ResumeLayout(false);
        tableLayoutPanel1.PerformLayout();
        ResumeLayout(false);
    }

    #endregion

    private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
    private System.Windows.Forms.Label lblTheAnswer;
}
