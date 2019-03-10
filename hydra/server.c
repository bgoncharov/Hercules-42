/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bogoncha <bogoncha@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/03/06 19:40:37 by bogoncha          #+#    #+#             */
/*   Updated: 2019/03/09 20:29:28 by bogoncha         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define BUFF_SIZE 256

int		connection(int lisfd, char *buf, struct sockaddr_in addr, int flg)
{
	int			ret;
	int			sockfd;
	socklen_t	addr_size;

	while (1)
	{
		if (flg)
			daemon(1, 1);
		addr_size = sizeof(addr);
		sockfd = accept(lisfd, (struct sockaddr *)&addr, &addr_size);
		if (sockfd < 0)
		{
			perror("accept");
			return (0);
		}
		else
		{
			ret = recv(sockfd, buf, BUFF_SIZE - 1, 0);
			buf[ret] = '\0';
			if (!strncmp(buf, "ping", 4))
				send(sockfd, "pong\npong\n", 10, 0);
		}
		close(sockfd);
	}
	return (0);
}

void	put_error(char *msg)
{
	perror(msg);
	exit(0);
}

int		main(int argc, char **argv)
{
	int					lisfd;
	char				buf[BUFF_SIZE];
	struct sockaddr_in	addr;
	int					flg;

	flg = 0;
	if (argc < 2 || argc > 3)
	{
		printf("usage: %s [[-D] [PORT]]\n", argv[0]);
		return (0);
	}
	if (argc == 3 && !strcmp(argv[1], "-D"))
		flg = 1;
	lisfd = socket(AF_INET, SOCK_STREAM, 0);
	if (lisfd < 0)
		put_error("socket");
	memset(&addr, '0', sizeof(addr));
	addr.sin_family = AF_INET;
	addr.sin_port = htons(atoi(argv[1]));
	addr.sin_addr.s_addr = htonl(INADDR_ANY);
	if (bind(lisfd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		put_error("bind");
	listen(lisfd, 5);
	connection(lisfd, buf, addr, flg);
	return (0);
}
