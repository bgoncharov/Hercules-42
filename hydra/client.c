/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bogoncha <bogoncha@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/03/07 14:21:06 by bogoncha          #+#    #+#             */
/*   Updated: 2019/03/09 20:12:44 by bogoncha         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <arpa/inet.h>
#define BUFF_SIZE 256

void	put_error(char *msg)
{
	perror(msg);
	exit(0);
}

int		main(int argc, char **argv)
{
	int					sockfd;
	char				buf[BUFF_SIZE];
	struct sockaddr_in	addr;

	if (argc != 3)
	{
		printf("Error. Usage: %s [IP] [PORT]\n", argv[0]);
		return (0);
	}
	if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0)
		put_error("socket");
	addr.sin_family = AF_INET;
	addr.sin_port = htons(atoi(argv[2]));
	addr.sin_addr.s_addr = inet_addr(argv[1]);
	if (connect(sockfd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		put_error("connect");
	printf("Enter the message: ");
	bzero(buf, BUFF_SIZE);
	fgets(buf, BUFF_SIZE - 1, stdin);
	send(sockfd, buf, strlen(buf), 0);
	bzero(buf, BUFF_SIZE);
	recv(sockfd, buf, 10, 0);
	printf("%s", buf);
	close(sockfd);
	return (0);
}
