# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dmanuel- <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/06 11:08:41 by dmanuel-          #+#    #+#              #
#    Updated: 2023/01/16 13:55:17 by dmanuel-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC=cc
CFLAGS= -Wall -Werror -Wextra -g
DEP= libft/libft.a

SRCC=client.c
OBJC=$(SRCC:.c=.o)
SRCSV=server.c
OBJSV=$(SRCSV:.c=.o)
NAME=client
NAME_SV=server

LIBFT=libft/libft.a

SRCC_BONUS=client_bonus.c
OBJC_BONUS=$(SRCC_BONUS:.c=.o)
SRCSV_BONUS=server_bonus.c
OBJSV_BONUS=$(SRCSV_BONUS:.c=.o)
NAME_BONUS=client_bonus
NAME_SV_BONUS=server_bonus

all: dep $(NAME) $(NAME_SV)
dep:
	$(MAKE) -C ./libft
$(NAME): $(OBJC) $(DEP)
	$(CC) $(CFLAGS) $(OBJC) $(LIBFT) -o $(NAME)
$(NAME_SV): $(OBJSV) $(DEP)
	$(CC) $(CFLAGS) $(OBJSV) $(LIBFT) -o $(NAME_SV)

bonus: dep all $(NAME_BONUS) $(NAME_SV_BONUS)

$(NAME_BONUS): $(OBJC_BONUS) $(DEP)
	$(CC) $(CFLAGS) $(OBJC_BONUS) $(LIBFT) -o $(NAME_BONUS)
$(NAME_SV_BONUS): $(OBJSV_BONUS) $(DEP)
	$(CC) $(CFLAGS) $(OBJSV_BONUS) $(LIBFT) -o $(NAME_SV_BONUS)

clean:
	rm -rf $(OBJC) $(OBJSV) 
	rm -rf $(OBJC_BONUS) $(OBJSV_BONUS)
	make -C libft clean

fclean: clean
		rm -rf server client libft/libft.a server_bonus client_bonus

re: fclean all bonus
