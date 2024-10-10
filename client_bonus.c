/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dmanuel- <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/01/06 11:18:27 by dmanuel-          #+#    #+#             */
/*   Updated: 2023/01/06 11:18:31 by dmanuel-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <signal.h>
#include <stdlib.h>
#include <unistd.h>
#include "libft/libft.h"

static void	action(int sig)
{
	static int	i;

	if (!i)
		i = 0;
	if (sig == SIGUSR1)
		i++;
	ft_putstr_fd("Received ", 1);
	ft_putnbr_fd(i, 1);
	ft_putstr_fd(" characters", 1);
	ft_putchar_fd('\n', 1);
}

static void	mt_kill(int pid, char *str)
{
	int		i;
	char	c;

	while (*str)
	{
		i = 8;
		c = *str++;
		while (i--)
		{
			if (c >> i & 1)
				kill(pid, SIGUSR2);
			else
				kill(pid, SIGUSR1);
			usleep(100);
		}	
	}
	i = 8;
}

int	main(int argc, char **argv)
{
	struct sigaction	s_sigaction;

	if (argc != 3 || !ft_strlen(argv[2]))
		return (1);
	s_sigaction.sa_handler = &action;
	s_sigaction.sa_flags = SA_SIGINFO;
	sigaction(SIGUSR1, &s_sigaction, 0);
	sigaction(SIGUSR2, &s_sigaction, 0);
	mt_kill(ft_atoi(argv[1]), argv[2]);
	while (1)
		pause();
	return (0);
}
