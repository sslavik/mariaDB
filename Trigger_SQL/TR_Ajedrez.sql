delimiter //

drop trigger if exists bi_partida//
drop trigger if exists ai_participante//
drop trigger if exists bi_arbitro//
drop trigger if exists bu_arbitro//
drop trigger if exists bi_jugador//
drop trigger if exists bu_jugador//

create trigger if not exists bi_partida before insert on partida
for each row
begin
    if (select pais from participante where nSocio = new.arbitro) in 
        (select pais from participante where nSocio = new.jugadorBlancas or nSocio = new.jugadorNegras) then
        signal sqlstate '45000' set mysql_errno = 5002, message_text = "El arbitro no puede ser del mismo pais";
    end if;
end//

create trigger if not exists ai_participante after insert on participante
for each row
begin
    if(new.tipo = "J") then
        insert into jugador value (new.nSocio, "1");
    elseif(new.tipo = "A") then
        insert into arbitro value (new.nSocio);
    end if;
end//

create trigger if not exists bi_jugador before insert on jugador
for each row
begin
    if exists (select nSocio from arbitro where new.nSocio = nSocio)
        signal sqlstate '45000' set mysql_errno = 5003, message_text = "El jugador no puede ser arbitro y jugador al mismo tiempo" ;
    end if;
end//

create trigger if not exists bu_jugador before update on jugador
for each row
begin
    if exists (select nSocio from arbitro where new.nSocio = nSocio)
        signal sqlstate '45000' set mysql_errno = 5003, message_text = "El jugador no puede ser arbitro y jugador al mismo tiempo" ;
    end if;
end//

create trigger if not exists bu_arbitro before update on arbitro
for each row
begin
    if exists (select nSocio from jugador where new.nSocio = nSocio)
        signal sqlstate '45000' set mysql_errno = 5003, message_text = "El jugador no puede ser arbitro y jugador al mismo tiempo" ;
    end if;
end//

create trigger if not exists bi_arbitro before insert on arbitro
for each row
begin
    if exists (select nSocio from jugador where new.nSocio = nSocio)
        signal sqlstate '45000' set mysql_errno = 5003, message_text = "El jugador no puede ser arbitro y jugador al mismo tiempo" ;
    end if;
end//

delimiter ;