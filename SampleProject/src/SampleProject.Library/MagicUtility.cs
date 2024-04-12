// Copyright (C) Tenacom and Contributors. Licensed under the MIT license.
// See the LICENSE file in the project root for full license information.

namespace SampleProject.Library;

/// <summary>
/// <para>Provides methods that deal with the Question about the Life, Universe, and Everything.</para>
/// <para>Or better, with the answer to it.</para>
/// <para>R.I.P. Douglas Adams (1952-2011).</para>
/// </summary>
public static class MagicUtility
{
    private const int TheAnswer = 42;

#pragma warning disable SA1629 // Documentation text should end with a period - An exclamation mark will do, too.
    /// <summary>
    /// Gets the answer to the question on life, the Universe, and everything.
    /// </summary>
    /// <returns>The answer.</returns>
    /// <remarks>
    /// <para>If only we could remember what the question was!</para>
    /// </remarks>
    /// <seealso cref="IsTheAnswer"/>
#pragma warning restore SA1629 // Documentation text should end with a period
    public static int GetTheAnswer() => TheAnswer;

    /// <summary>
    /// Gets a value indicating whether the given <paramref name="answer"/>
    /// is the answer to the question on life, the Universe, and everything.
    /// </summary>
    /// <param name="answer">The answer to check.</param>
    /// <returns><see langword="true"/> if <paramref name="answer"/> is the answer  to the question on life, the Universe, and everything;
    /// <see langword="false"/> otherwise.</returns>
    /// <seealso cref="GetTheAnswer"/>
    public static bool IsTheAnswer(int answer) => answer == TheAnswer;
}
