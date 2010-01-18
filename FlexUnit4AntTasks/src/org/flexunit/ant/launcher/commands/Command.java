package org.flexunit.ant.launcher.commands;

import java.io.IOException;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.Execute;
import org.apache.tools.ant.types.Commandline;

public abstract class Command extends Execute
{
	private Project project;
	private Commandline commandLine;

	public Command()
	{
		super();
		this.commandLine = new Commandline();
	}

	public void setProject(Project project)
	{
		this.project = project;
	}

	public Project getProject()
	{
		return project;
	}

	public Commandline getCommandLine()
	{
		return commandLine;
	}

	@Override
	public int execute() throws IOException
	{
		// prepare the task
		super.setAntRun(project);
		super.setWorkingDirectory(project.getBaseDir());
		super.setCommandline(getCommandLine().getCommandline());

		return super.execute();
	}

	public String describe()
	{
		return getCommandLine().describeCommand();
	}
}
