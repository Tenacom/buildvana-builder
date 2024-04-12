// Copyright (C) Tenacom and Contributors. Licensed under the MIT license.
// See the LICENSE file in the project root for full license information.

using SampleProject.Library;

public class MagicUtilityTests
{
    [Fact]
    public void GetTheAnswer_ReturnsAnInteger()
    {
        object? answer = MagicUtility.GetTheAnswer();
        answer.Should().BeOfType<int>();
    }

    [Fact]
    public void GetTheAnswer_ReturnsTheCorrectValue()
    {
        var answer = MagicUtility.GetTheAnswer();
        answer.Should().Be(42);
    }

    [Theory]
    [InlineData(0, false)]
    [InlineData(int.MinValue, false)]
    [InlineData(-1, false)]
    [InlineData(-42, false)]
    [InlineData(41, false)]
    [InlineData(42, true)]
    [InlineData(43, false)]
    [InlineData(int.MaxValue, false)]
    public void IsTheAnswer_ReturnsTheCorrectValue(int answer, bool isTheAnswer)
    {
        var response = MagicUtility.IsTheAnswer(answer);
        response.Should().Be(isTheAnswer);
    }
}
