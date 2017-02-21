--Модуль печати ext отчётов

function to_str(__non_str_value)
        local str_value_w = tostring(__non_str_value);
        
        return str_value_w;
end

function report_ext_general_header(__rep, __width, shift_number)
     local text = "";
     local shift_id = ukm.get_shift_id_from_number(tonumber(shift_number));

     local open_date = ukm.shift_open_date(shift_id:get());
     local close_date = ukm.shift_close_date(shift_id:get());
     if shift_id ~= nil then
       if (ukm.shift_is_closed(shift_id:get())) then
           text = text .. "*" .. ukm.center("ОТЧЁТ ЗА ЗАКРЫТУЮ СМЕНУ " .. ukm.leftpad(shift_number,5,"0"), __width-2," ") .. "*" .. "\n";
           if open_date ~= nil and close_date ~= nil then
              text = text .. "*" .. ukm.adjustment(" ОТКРЫТА", ukm.ptime2str(open_date, "%d-%m-%Y %H:%M"), __width-2," ") .. "*" .. "\n";
              text = text .. "*" .. ukm.adjustment(" ЗАКРЫТА", ukm.ptime2str(close_date, "%d-%m-%Y %H:%M"), __width-2," ") .. "*" .. "\n";
           end 
           text = text .. ukm.rightpad("*",__width,"*") .. "\n";
       else
          if open_date ~= nil then
             text = text .. "*" .. ukm.adjustment(" ОТКРЫТА: ", ukm.ptime2str(open_date, "%d-%m-%Y %H:%M"), __width-2," ") .. "*" .. "\n";
          end
       end
     end

     if __width < 30 then
       text = text .. ukm.adjustmentdouble( "ОПР:" .. ukm.left(ukm.get_login().name,__width-4), ukm.ptime2str(ukm.get_sys_date(), "%d-%m-%Y %H:%M"),__width," ") .. "\n";
     else
       text = text .. ukm.adjustment( "ОПР:" .. ukm.left(ukm.get_login().name,__width-21), ukm.ptime2str(ukm.get_sys_date(), "%d-%m-%Y %H:%M"),__width," ") .. "\n";
     end

     text = text .. ukm.adjustmentdouble( "ОТЧЕТ:" .. ukm.left(ukm.leftpad(tostring(ukm.get_pos_number()),3,"0"),3) .. ukm.left(ukm.leftpad(tostring(ukm.get_shift_number()),5,"0"),5) .. ukm.left(ukm.leftpad(tostring(__rep.local_number),4,"0"),4), "      ТРН:" .. ukm.left(ukm.leftpad(tostring(__rep.global_number),12,"0"),12),__width," ") .. "\n";
     text = text .. ukm.rightpad("-",__width,"-") .. "\n";
        
  return text;
end 


--Акт о возврате, название внешнего скрипта
function report_ext_returns_document(__rep, __print_data)
    local printer = ukm.get_printer(ukm.printer_type_master());
    if printer then
        local text = "";
        local width = printer:get_width();
        local shift_number = ukm.get_shift_number_from_user();
        if ukm.str_len(shift_number) ~= 0 then
            text = report_ext_general_header(__rep,width, shift_number) ;
            text = text .. " " .. "\n";
            text = text .. hw_command_double_weight;

            if width < 30 then
               text = text .. ukm.center("АКТ", width," ") .. "\n";
            else
               text = text .. ukm.center("АКТ", width-20," ") .. "\n";
            end

            text = text .. " " .. "\n";
            text = text .. hw_command_single_weight;

            if width < 30 then 
              text = text .. ukm.center("О ВОЗВРАТЕ ДЕНЕЖНЫХ", width," ") .. "\n";
              text = text .. ukm.center("СУММ ПОКУПАТЕЛЯМ", width," ") .. "\n";
              text = text .. ukm.center("(КЛИЕНТАМ) ПО", width," ") .. "\n";
              text = text .. ukm.center("НЕИСПОЛЬЗОВАННЫМ", width," ") .. "\n";
              text = text .. ukm.center("КАССОВЫМ ЧЕКАМ", width," ") .. "\n";
              text = text .. ukm.center("(в том числе по", width," ") .. "\n";
              text = text .. ukm.center("ошибочно пробитым ", width," ") .. "\n";
              text = text .. ukm.center("кассовым чекам)", width," ") .. "\n";
              text = text .. ukm.adjustmentdouble("ККМ N " .. tostring(ukm.get_pos_number()), "ЗА СМЕНУ N " .. shift_number, width," ") .. "\n";
              text = text .. ukm.rightpad("-",width,"-") .. "\n";
              text = text .. ukm.adjustmentdouble("N ВОЗВР.ЧЕКА","СУММА ВОЗВРАТА(РУБ)",width," ") .. "\n";
              text = text .. ukm.rightpad("-",width,"-") .. "\n";
            else
              text = text .. ukm.center("О ВОЗВРАТЕ ДЕНЕЖНЫХ СУММ ПОКУПАТЕЛЯМ", width," ") .. "\n";
              text = text .. ukm.center("(КЛИЕНТАМ) ПО НЕИСПОЛЬЗОВАННЫМ", width," ") .. "\n";
              text = text .. ukm.center("КАССОВЫМ ЧЕКАМ", width," ") .. "\n";
              text = text .. ukm.center("(в том числе по ошибочно пробитым", width," ") .. "\n";
              text = text .. ukm.center("кассовым чекам)", width," ") .. "\n";
              text = text .. ukm.adjustmentdouble("КСА № " .. tostring(ukm.get_pos_number()), "ЗА СМЕНУ № " .. shift_number, width," ") .. "\n";
              text = text .. ukm.rightpad("-",width,"-") .. "\n";
              text = text .. ukm.adjustmentdouble("№ ВОЗВР.ЧЕКА","СУММА ВОЗВРАТА (РУБ.)",width," ") .. "\n";
              text = text .. ukm.rightpad("-",width,"-") .. "\n";
           end
           
            local total_amount = ukm.currency(0); 
            local text_select = "";
            text_select = text_select .. "select h.local_number, sum(p.amount) from trm_out_shift_open so "
                                      .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                      .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                      .. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and h.cash_id = p.cash_id "
                                      .. "where so.number = " .. shift_number .. " "
                                      .. "and ( h.type = " .. tostring(ukm.header.creturn) .. " or " .. "h.type = " .. tostring(ukm.header.returnbyreceipt) .. ") "
                                      .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                      .. "and p.type = " .. tostring(ukm.payment.normal) .. " "
                                      .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                      .. "group by h.local_number";

            local qry_receipt_returns = ukm.query(__rep:get_conn(), text_select);
            receipt_returns_table = {};      

            while qry_receipt_returns:fetch() do
                 local l_number = ukm.from_mysql.int(qry_receipt_returns:get_field(0));
                 local sum = ukm.from_mysql.currency(qry_receipt_returns:get_field(1));
                 receipt_returns_table[l_number] = {};
                 receipt_returns_table[l_number].l_number = l_number;
                 receipt_returns_table[l_number].sum = sum;
            end 
            for ik, iv in pairs(receipt_returns_table) do
                local amount = iv.sum;
                total_amount = total_amount + amount;
                local text_v = "";
                text_v = text_v .. ukm.adjustmentdouble(tostring(iv.l_number), to_str(amount), width, " ") .. "\n";
                text = text .. text_v;
            end
            text = text .. ukm.rightpad("-",width,"-") .. "\n";
            text = text .. ukm.slice("Выдано покупателям  (клиентам)    по возвращенным ими кассовым чекам (по ошибочно пробитым чекам) согласно акту на сумму: ",width) .. "\n";
--           
            text = text .. "  " .. ukm.slice(to_str(ukm.num2txt(total_amount)), width) .. "\n";
--            text = text .. ukm.slice("На указанную сумму следует уменьшить выручку кассы. Перечисленные возвращенные покупателями (клиентами) чеки (ошибочно пробитые чеки) погашены и прилагаются к акту.", width) .. "\n";
            text = text .. ukm.rightpad("Приложение",width-1,"_") .. "." .. "\n";
            text = text .. ukm.rightpad("ЧЛЕНЫ КОМИССИИ:",width," ") .. "\n";
            if width < 30 then 
              text = text .. ukm.rightpad("ЗАВ.ОТДЕЛОМ(СЕКЦИЕЙ)",width," ") .. "\n" .." \n";
              text = text .. ukm.rightpad("СТАРШИЙ КАССИР",width," ") .. "\n" .. " \n";
              text = text .. ukm.rightpad("КАССИР-ОПЕРАЦИОНИСТ",width," ") .. "\n" .." \n";
            else
              text = text .. ukm.rightpad("ЗАВЕДУЮЩИЙ ОТДЕЛОМ(СЕКЦИЕЙ)",width," ") .. "\n";
              text = text .. ukm.rightpad("СТАРШИЙ КАССИР",width," ") .. "\n";
              text = text .. ukm.rightpad("КАССИР-ОПЕРАЦИОНИСТ",width," ") .. "\n";
            end
            text = text .. " " .. "\n";
            
            __print_data:add(text, ukm.printer_type_master());
        end
    end
end

--Отчёт по отчет на кассе по налогам в разрезе кассиров
function report_ext_cashier_taxes(__rep, __print_data)
    local printer = ukm.get_printer(ukm.printer_type_master());
    if printer then
       local text = "";
       local text_p = "";
       local width = printer:get_width();
       local shift_number = ukm.get_shift_number_from_user();
       if ukm.str_len(shift_number) ~= 0 then
          text = report_ext_general_header(__rep,width, shift_number) ;
          text_p = text_p .. ukm.center("ОТЧЁТ ПО КАССИРАМ", width," ") .. "\n";
          text = text .. text_p;
          if width > 29 then
            text = text .. ukm.adjustment("КАССИР   В(ШТ) П","ВОЗВРАТ(РУБ)ПРОДАЖА",width, " ") .. "\n";
          end
          
          local text_select = "";
--выбираем кассиров которые работали в выбранной смене
          text_select = text_select .. "select l.user_id, l.user_name from trm_out_shift_open so "
                                      .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                      .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                      .. "inner join trm_out_login l on h.login = l.id and h.cash_id = l.cash_id "
                                      .. "where so.number = " .. shift_number .. " "
                                      .. "and h.type in (" .. tostring(ukm.header.sale) .. ", " .. tostring(ukm.header.creturn) .. ", " .. tostring(ukm.header.returnbyreceipt) .. ", " .. tostring(ukm.header.pop) .. ") "
                                      .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                      .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                      .. "group by h.local_number";

          local qry_cashier = ukm.query(__rep:get_conn(), text_select);
          cashier_table = {}; 
--результаты запроса помещаем в таблицу, ключом уникальности записи является идентификатор кассира
          while qry_cashier:fetch() do
             local u_id = ukm.from_mysql.int(qry_cashier:get_field(0));
             local u_name = ukm.from_mysql.string(qry_cashier:get_field(1));
             if cashier_table[u_id] == nil then
                cashier_table[u_id] = {};
                cashier_table[u_id].id = u_id;
                cashier_table[u_id].name = u_name; 
             end
          end 
          for ick, icv in pairs(cashier_table) do
              text_p = ukm.adjustment(" " .. tostring(icv.name), " ", width, " ") .. "\n";
              text = text .. text_p;
 
              text_select = "";
--для каждого кассира из предыдущего запроса, получаем скидки, использованные им (имя скидки, процент, и идентификатор)
              text_select = text_select .. "select t.name, t.percent, t.tax_id from trm_out_shift_open so "
                                      .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                      .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                      .. "inner join trm_out_login l on h.login = l.id and h.cash_id = l.cash_id "
                                      .. "inner join trm_out_receipt_item i on h.id = i.receipt_header and h.cash_id = i.cash_id "
                                      .. "left join trm_out_receipt_item i2 on i.receipt_header = i2.receipt_header and i.id = i2.link_item and i.cash_id = i2.cash_id "
                                      .. "inner join trm_out_receipt_item_tax it on i.id = it.receipt_item and i.cash_id = it.cash_id "
                                      .. "inner join trm_out_receipt_tax t on it.receipt_tax = t.id and it.cash_id = t.cash_id "
                                      .. "where so.number = " .. shift_number .. " "
                                      .. "and h.type in (" .. tostring(ukm.header.sale) .. ", " .. tostring(ukm.header.creturn) .. ", " .. tostring(ukm.header.returnbyreceipt) .. ", " .. tostring(ukm.header.pop) .. ") "
                                      .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                      .. "and l.user_id = " .. tostring(icv.id) .. " "
                                      .. "and i.type = " .. tostring(ukm.item.normal) .. " "
                                      .. "and i2.link_item is null "
                                      .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                      .. "group by t.tax_id, t.percent";              
            
              local qry_tax = ukm.query(__rep:get_conn(), text_select);
              tax_table = {}; 
--результаты запроса помещаем в таблицу, ключом уникальности записи является идентификатор скидки и процент
              while qry_tax:fetch() do
                 local t_id = ukm.from_mysql.int(qry_tax:get_field(2));
                 local t_name = ukm.from_mysql.string(qry_tax:get_field(0));
                 local t_percent = ukm.from_mysql.string(qry_tax:get_field(1));
                 if tax_table[tostring(t_id) .. t_percent] == nil then   
                    tax_table[tostring(t_id) .. t_percent] = {};
                    tax_table[tostring(t_id) .. t_percent].id = t_id;
                    tax_table[tostring(t_id) .. t_percent].name = t_name;
                    tax_table[tostring(t_id) .. t_percent].percent = t_percent; 
                 end

              
              end
 
              for itk, itv in pairs(tax_table) do     
                    local taxcountreturn;
                    local taxcountsale;
                    local taxreturn;
                    local taxsale;
--для каждой скидки из предыдущего запроса, получаем сумму данной скидки в возвратах
                    text_select = "";
                    text_select = text_select .. "select if(sum(t.amount) is null, 0, sum(t.amount)) from trm_out_shift_open so "
                                      .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                      .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                      .. "inner join trm_out_login l on h.login = l.id and h.cash_id = l.cash_id "
                                      .. "inner join trm_out_receipt_item i on h.id = i.receipt_header and h.cash_id = i.cash_id "
                                      .. "left join trm_out_receipt_item i2 on i.receipt_header = i2.receipt_header and i.id = i2.link_item and i.cash_id = i2.cash_id "
                                      .. "inner join trm_out_receipt_item_tax it on i.id = it.receipt_item and i.cash_id = it.cash_id "
                                      .. "inner join trm_out_receipt_tax t on it.receipt_tax = t.id and it.cash_id = t.cash_id "
                                      .. "where so.number = " .. shift_number .. " "
                                      .. "and h.type in (" .. tostring(ukm.header.creturn) .. ", " .. tostring(ukm.header.returnbyreceipt) .. ") "
                                      .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                      .. "and l.user_id = " .. tostring(icv.id) .. " "
                                      .. "and i.type = " .. tostring(ukm.item.normal) .. " "
                                      .. "and i2.link_item is null "
                                      .. "and t.tax_id = " .. tostring(itv.id) .. " "
                                      .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                      .. "and t.percent = '" .. itv.percent .. "'";
                  local qry_tax_return = ukm.query(__rep:get_conn(), text_select);
                  while qry_tax_return:fetch() do
                     taxreturn = ukm.from_mysql.currency(qry_tax_return:get_field(0));
                  end 

--для каждой скидки из предыдущего запроса, получаем количество позиций возвращённых с данной скидкой
                  text_select = "";
                  text_select = text_select .. "select if(count(t.amount) is null, 0, count(t.amount)) from trm_out_shift_open so "
                                      .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                      .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                      .. "inner join trm_out_login l on h.login = l.id and h.cash_id = l.cash_id "
                                      .. "inner join trm_out_receipt_item i on h.id = i.receipt_header and h.cash_id = i.cash_id "
                                      .. "left join trm_out_receipt_item i2 on i.receipt_header = i2.receipt_header and i.id = i2.link_item and i.cash_id = i2.cash_id "
                                      .. "inner join trm_out_receipt_item_tax it on i.id = it.receipt_item and i.cash_id = it.cash_id "
                                      .. "inner join trm_out_receipt_tax t on it.receipt_tax = t.id and it.cash_id = t.cash_id "
                                      .. "where so.number = " .. shift_number .. " "
                                      .. "and h.type in (" .. tostring(ukm.header.creturn) .. ", " .. tostring(ukm.header.returnbyreceipt) .. ") "
                                      .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                      .. "and l.user_id = " .. tostring(icv.id) .. " "
                                      .. "and i.type = " .. tostring(ukm.item.normal) .. " "
                                      .. "and i2.link_item is null "
                                      .. "and t.tax_id = " .. tostring(itv.id) .. " "
                                      .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                      .. "and t.percent = '" .. itv.percent .. "'";

                  local qry_tax_count_return = ukm.query(__rep:get_conn(), text_select);
                  while qry_tax_count_return:fetch() do
                     taxcountreturn = ukm.from_mysql.int(qry_tax_count_return:get_field(0));
                  end 

--для каждой скидки из предыдущего запроса, получаем сумму данной скидки в продажах
                  text_select = "";
                  text_select = text_select .. "select if(sum(t.amount) is null, 0, sum(t.amount)) from trm_out_shift_open so "
                                      .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                      .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                      .. "inner join trm_out_login l on h.login = l.id and h.cash_id = l.cash_id "
                                      .. "inner join trm_out_receipt_item i on h.id = i.receipt_header and h.cash_id = i.cash_id "
                                      .. "left join trm_out_receipt_item i2 on i.receipt_header = i2.receipt_header and i.id = i2.link_item and i.cash_id = i2.cash_id "
                                      .. "inner join trm_out_receipt_item_tax it on i.id = it.receipt_item and i.cash_id = it.cash_id "
                                      .. "inner join trm_out_receipt_tax t on it.receipt_tax = t.id and it.cash_id = t.cash_id "
                                      .. "where so.number = " .. shift_number .. " "
                                      .. "and h.type in (" .. tostring(ukm.header.sale) .. ", " .. tostring(ukm.header.pop) .. ") "
                                      .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                      .. "and l.user_id = " .. tostring(icv.id) .. " "
                                      .. "and i.type = " .. tostring(ukm.item.normal) .. " "
                                      .. "and i2.link_item is null "
                                      .. "and t.tax_id = " .. tostring(itv.id) .. " "
                                      .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                      .. "and t.percent = '" .. itv.percent .. "'";
                  local qry_tax_sale = ukm.query(__rep:get_conn(), text_select);
                  while qry_tax_sale:fetch() do
                     taxsale = ukm.from_mysql.currency(qry_tax_sale:get_field(0));
                  end 

--для каждой скидки из предыдущего запроса, получаем количество проданных позицийс данной скидкой
                  text_select = "";
                  text_select = text_select .. "select if(count(t.amount) is null, 0, count(t.amount)) from trm_out_shift_open so "
                                      .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                      .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                      .. "inner join trm_out_login l on h.login = l.id and h.cash_id = l.cash_id "
                                      .. "inner join trm_out_receipt_item i on h.id = i.receipt_header and h.cash_id = i.cash_id "
                                      .. "left join trm_out_receipt_item i2 on i.receipt_header = i2.receipt_header and i.id = i2.link_item and i.cash_id = i2.cash_id "
                                      .. "inner join trm_out_receipt_item_tax it on i.id = it.receipt_item and i.cash_id = it.cash_id "
                                      .. "inner join trm_out_receipt_tax t on it.receipt_tax = t.id and it.cash_id = t.cash_id "
                                      .. "where so.number = " .. shift_number .. " "
                                      .. "and h.type in (" .. tostring(ukm.header.sale) .. ", " .. tostring(ukm.header.pop) .. ") "
                                      .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                      .. "and l.user_id = " .. tostring(icv.id) .. " "
                                      .. "and i.type = " .. tostring(ukm.item.normal) .. " "
                                      .. "and i2.link_item is null "
                                      .. "and t.tax_id = " .. tostring(itv.id) .. " "
                                      .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                      .. "and t.percent = '" .. itv.percent .. "'";
                  local qry_tax_count_sale = ukm.query(__rep:get_conn(), text_select);
                  while qry_tax_count_sale:fetch() do
                     taxcountsale = ukm.from_mysql.int(qry_tax_count_sale:get_field(0));
                  end 

                  text_p = "";
                  if width < 30 then
                   text_p = ukm.adjustmentdouble(itv.name , itv.percent, width," ") .. "\n";
                   text_p = text_p .. ukm.adjustmentdouble("В(ШТ)",tostring(taxcountreturn), width," ") .. "\n";
                   text_p = text_p .. ukm.adjustmentdouble("П",tostring(taxcountsale), width," ") .. "\n";
                   text_p = text_p .. ukm.adjustmentdouble("ВОЗВРАТ(РУБ)",tostring(taxreturn), width," ") .. "\n";
                   text_p = text_p .. ukm.adjustmentdouble("ПРОДАЖА(РУБ)",tostring(taxsale), width," ") .. "\n";
                  else
                   text_p = ukm.rightpad(itv.name .. "," .. itv.percent, width," ") .. "\n";
                   text_p = text_p .. ukm.leftpad(tostring(taxcountreturn), width-29," ");
                   text_p = text_p .. ukm.leftpad(tostring(taxcountsale), width-35," ");  
                   text_p = text_p .. ukm.leftpad(tostring(taxreturn), width-28," ");
                   text_p = text_p .. ukm.leftpad(tostring(taxsale), width-28," ") .. "\n";
                  end
                  text = text .. text_p;
              end              
          end
          
          __print_data:add(text, ukm.printer_type_master());
       end
    end
end


--Отчет по платежным средствам, название внешнего скрипта
function report_ext_payment_type(__rep, __print_data)
        local printer = ukm.get_printer(ukm.printer_type_master());
        if printer then
                local text = "";
                local width = printer:get_width();
                local shift_number = ukm.get_shift_number_from_user();
                if ukm.str_len(shift_number) ~= 0 then
                        text = report_ext_general_header(__rep, width, shift_number) .. " " .. "\n"
                                .. ukm.center("ОТЧЕТ ПО ПЛАТЕЖНЫМ", width, " ") .. "\n"
                                .. ukm.center("СРЕДСТВАМ", width, " ") .. "\n"
                                .. " " .. "\n"
                                .. ukm.adjustment("СР-ВО/ОПЕРАЦИЯ  К-ВО","СУММА(РУБ)",width, " ") .. "\n"
                                .. " " .. "\n";

                        local text_select = "";

                        local before_shift_id = "0";

                        text_select = "select id from trm_out_shift_open where cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                                .. "and number < " .. shift_number .. " "
                                                .. "order by id desc "
                                                .. "limit 1";
                                                local qry_before_shift_id = ukm.query(__rep:get_conn(), text_select);
                        if qry_before_shift_id:fetch() then
                                before_shift_id = ukm.from_mysql.string(qry_before_shift_id:get_field(0));
                        end

			text_select = "select p.payment_id, p.payment_name, e.efts from trm_out_shift_open so "
                                                .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                                .. "inner join trm_out_receipt_footer f on h.id = f.id and f.cash_id = h.cash_id "
                                                .. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and p.cash_id = h.cash_id "
						.. "INNER JOIN trm_in_pos pos ON pos.cash_id = h.cash_id "
						.. "INNER JOIN trm_in_payments ppp ON ppp.store_id = pos.store_id AND ppp.id = p.payment_id "
						.. "INNER JOIN trm_in_equarings e ON e.store_id = pos.store_id AND e.id = ppp.equaring_id "
                                                .. "where so.number = " .. shift_number .. " "
                                                .. "and h.type in (" .. tostring(ukm.header.sale) .. "," .. tostring(ukm.header.creturn) .. "," .. tostring(ukm.header.returnbyreceipt) .. "," .. tostring(ukm.header.pop) .. ") "
                                                .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                                .. "and p.type = " .. tostring(ukm.payment.normal) .. " "
                                                .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                                .. "group by p.payment_id "
                                                .. "union "
						.. "select m.payment_id, m.payment_name, e.efts from trm_out_moneyoperation m "
						.. "INNER JOIN trm_in_pos pos ON pos.cash_id = m.cash_id "
						.. "INNER JOIN trm_in_payments ppp ON ppp.store_id = pos.store_id AND ppp.id = m.payment_id "
						.. "INNER JOIN trm_in_equarings e ON e.store_id = pos.store_id AND e.id = ppp.equaring_id "
                                                .. "where m.shift_number = " ..  shift_number .. " "
                                                .. "and m.type in (" .. tostring(ukm.moneyoperation.insert) .. "," .. tostring(ukm.moneyoperation.extract) .. ") "
                                                .. "and m.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                                .. "group by m.payment_id "
                                                .. "union "
						.. "select sp.payment, ifnull(p.name, sp.payment), e.efts from trm_in_pos pos "
                                                .. "inner join trm_out_shift_payments sp on pos.cash_id = sp.cash_id "
                                                .. "left join trm_in_payments p on pos.store_id = p.store_id and sp.payment = p.id "
						.. "INNER JOIN trm_in_equarings e ON e.store_id = pos.store_id AND e.id = p.equaring_id "
                                                .. "where pos.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                                .. "and sp.id = " .. before_shift_id;

                        local qry_payments = ukm.query(__rep:get_conn(), text_select);
                        payments_table = {}; 
                        while qry_payments:fetch() do
                                local p_id = ukm.from_mysql.int(qry_payments:get_field(0));
                                local p_name = ukm.from_mysql.string(qry_payments:get_field(1));
				local efts = ukm.from_mysql.int(qry_payments:get_field(2));
                                payments_table[p_id] = {};
                                payments_table[p_id].id = p_id;
                                payments_table[p_id].name = p_name; 
				payments_table[p_id].efts = efts; 
				
                        end 

                        local total_count_insert = 0;
                        local total_sum_insert = ukm.currency(0);
                        local total_count_extract = 0;
                        local total_sum_extract = ukm.currency(0);
                        local total_count_sale = 0;
                        local total_sum_sale = ukm.currency(0);
                        local total_count_return = 0;
                        local total_sum_return = ukm.currency(0);
                        local total_profit = ukm.currency(0);
                        local total_sum_cash_box = ukm.currency(0);

                        for ipk, ipv in pairs(payments_table) do
                                text = text .. ukm.adjustment(tostring(ipv.name), " ", width, " ") .. "\n";

                                local sum_cash_box = ukm.currency(0);

                                text_select = "select ifnull(sum(sp.amount), '0.00') from trm_out_shift_payments sp "
                                                .. "where sp.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                                .. "and sp.id = " .. before_shift_id .. " "
                                                .. "and sp.payment = " .. ukm.to_mysql(ipv.id);
                                local qry_cash_box_before = ukm.query(__rep:get_conn(), text_select);

                                if qry_cash_box_before:fetch() then
                                        sum_cash_box = ukm.from_mysql.currency(qry_cash_box_before:get_field(0));   
                                end

                                text = text .. ukm.adjustment("НА НАЧАЛО В КАССЕ", to_str(sum_cash_box), width, " ") .. "\n";

                                local count_insert = 0;
                                local sum_insert = ukm.currency(0);
                                local count_extract = 0;
                                local sum_extract = ukm.currency(0);
                                local count_sale = 0;
                                local sum_sale = ukm.currency(0);
                                local count_return = 0;
                                local sum_return = ukm.currency(0);
                                local profit = ukm.currency(0);

                                text_select = "select l.user_id, l.user_name from trm_out_shift_open so "
                                                        .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                                        .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                                        .. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and h.cash_id = p.cash_id "
                                                        .. "inner join trm_out_login l on h.login = l.id and h.cash_id = l.cash_id "
                                                        .. "where so.number = " .. shift_number .. " "
                                                        .. "and h.type in (" .. tostring(ukm.header.sale) .. "," .. tostring(ukm.header.creturn) .. "," .. tostring(ukm.header.returnbyreceipt) .. "," .. tostring(ukm.header.pop) .. ") "
                                                        .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                                        .. "and p.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                                        .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                                        .. "group by l.user_id;";

                                local qry_users = ukm.query(__rep:get_conn(), text_select);
                                users_table = {}; 
                                while qry_users:fetch() do
                                        local u_id = ukm.from_mysql.int(qry_users:get_field(0));
                                        local u_name = ukm.from_mysql.string(qry_users:get_field(1));
                                        users_table[u_id] = {};
                                        users_table[u_id].id = u_id;
                                        users_table[u_id].name = u_name; 
                                end 

                                text_select = "select l.user_id, l.user_name from trm_out_moneyoperation m "
                                                        .. "inner join trm_out_login l on m.login = l.id and m.cash_id = l.cash_id "
                                                        .. "where m.shift_number = " ..  shift_number .. " "
                                                        .. "and m.type in (" .. tostring(ukm.moneyoperation.insert) .. "," .. tostring(ukm.moneyoperation.extract) .. ") "
                                                        .. "and m.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                                        .. "and m.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                                        .. "group by l.user_id;";

                                local qry_mo_users= ukm.query(__rep:get_conn(), text_select);

                                while qry_mo_users:fetch() do
                                        local u_id = ukm.from_mysql.int(qry_mo_users:get_field(0));
                                        local u_name = ukm.from_mysql.string(qry_mo_users:get_field(1));
                                        if users_table[u_id] == nil then
                                                users_table[u_id] = {};
                                                users_table[u_id].id = u_id;
                                                users_table[u_id].name = u_name; 
                                        end
                                end

                                for iuk, iuv in pairs(users_table) do
                                        text = text .. ukm.adjustment(" " .. tostring(iuv.name), " ", width, " ") .. "\n";
                                        local user_count_insert = 0;
   
                                        text_select = "select count(m.id) from trm_out_moneyoperation m "
                                                                .. "inner join trm_out_login l on m.login = l.id and m.cash_id = l.cash_id "
                                                                .. "where m.shift_number = " ..  shift_number .. " "
                                                                .. "and m.type = " .. tostring(ukm.moneyoperation.insert) .. " "
                                                                .. "and m.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                                                .. "and m.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                                                .. "and l.user_id = " .. ukm.to_mysql(iuv.id) .. ";";
                                        local qry_count_insert= ukm.query(__rep:get_conn(), text_select);

                                        while qry_count_insert:fetch() do
                                                user_count_insert = ukm.from_mysql.int(qry_count_insert:get_field(0));   
                                        end

                                        count_insert = count_insert + user_count_insert;   
                                        local user_sum_insert = ukm.currency(0);

                                        text_select = "select ifnull(sum(m.amount), '0.00') from trm_out_moneyoperation m "
                                                                .. "inner join trm_out_login l on m.login = l.id and m.cash_id = l.cash_id "
                                                                .. "where m.shift_number = " ..  shift_number .. " "
                                                                .. "and m.type = " .. tostring(ukm.moneyoperation.insert) .. " "
                                                                .. "and m.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                                                .. "and m.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                                                .. "and l.user_id = " .. ukm.to_mysql(iuv.id) .. ";";
                                        local qry_sum_insert= ukm.query(__rep:get_conn(), text_select);

                                        while qry_sum_insert:fetch() do
                                                user_sum_insert = ukm.from_mysql.currency(qry_sum_insert:get_field(0));   
                    end
                    sum_insert = sum_insert + user_sum_insert;

                    local user_count_extract = 0;
   
                    text_select = "select count(m.id) from trm_out_moneyoperation m "
                                .. "inner join trm_out_login l on m.login = l.id and m.cash_id = l.cash_id "
                                .. "where m.shift_number = " ..  shift_number .. " "
                                .. "and m.type = " .. tostring(ukm.moneyoperation.extract) .. " "
                                .. "and m.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and m.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                .. "and l.user_id = " .. ukm.to_mysql(iuv.id) .. ";";
                    local qry_count_extract= ukm.query(__rep:get_conn(), text_select);

                    while qry_count_extract:fetch() do
                        user_count_extract = ukm.from_mysql.int(qry_count_extract:get_field(0));   
                    end
                    count_extract = count_extract + user_count_extract; 

                    local user_sum_extract = ukm.currency(0);

                    text_select = "select ifnull(sum(m.amount), '0.00') from trm_out_moneyoperation m "
                                .. "inner join trm_out_login l on m.login = l.id and m.cash_id = l.cash_id "
                                .. "where m.shift_number = " ..  shift_number .. " "
                                .. "and m.type = " .. tostring(ukm.moneyoperation.extract) .. " "
                                .. "and m.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and m.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                .. "and l.user_id = " .. ukm.to_mysql(iuv.id) .. ";";
                    local qry_sum_extract = ukm.query(__rep:get_conn(), text_select);
                    while qry_sum_extract:fetch() do
                        user_sum_extract= ukm.from_mysql.currency(qry_sum_extract:get_field(0));   
                    end                   
                    sum_extract = sum_extract + user_sum_extract;

                    local user_count_sale = 0;

                    text_select = "select count(p.id) from trm_out_shift_open so "
                                .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                .. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and h.cash_id = p.cash_id "
                                .. "inner join trm_out_login l on h.login = l.id and h.cash_id = l.cash_id "
                                .. "where so.number = " .. shift_number .. " "
                                .. "and h.type in (" .. tostring(ukm.header.sale) .. "," .. tostring(ukm.header.pop) .. ") "
                                .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                .. "and p.type = " .. tostring(ukm.payment.normal) .. " "
                                .. "and p.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                .. "and l.user_id = " .. ukm.to_mysql(iuv.id) .. ";";
                    local qry_user_count_sale = ukm.query(__rep:get_conn(), text_select);
                    while qry_user_count_sale:fetch() do
                        user_count_sale = ukm.from_mysql.int(qry_user_count_sale:get_field(0));
                    end 

                    text_select = "select count(p.id) from trm_out_shift_open so "
                                .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                .. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and h.cash_id = p.cash_id "
                                .. "inner join trm_out_login l on h.login = l.id and h.cash_id = l.cash_id "
                                .. "where so.number = " .. shift_number .. " "
                                .. "and h.type in (" .. tostring(ukm.header.sale) .. "," .. tostring(ukm.header.pop) .. ") "
                                .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                .. "and p.type = " .. tostring(ukm.payment.void) .. " "
                                .. "and p.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                .. "and l.user_id = " .. ukm.to_mysql(iuv.id) .. ";";
                    qry_user_count_sale = ukm.query(__rep:get_conn(), text_select);
                    while qry_user_count_sale:fetch() do
                        user_count_sale = user_count_sale - ukm.from_mysql.int(qry_user_count_sale:get_field(0));
                    end

                    count_sale = count_sale + user_count_sale;

                    local user_sum_sale = ukm.currency(0);

                    text_select = "select ifnull(sum(p.amount), '0.00') from trm_out_shift_open so "
                                .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                .. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and h.cash_id = p.cash_id "
                                .. "inner join trm_out_login l on h.login = l.id and h.cash_id = l.cash_id "
                                .. "where so.number = " .. shift_number .. " "
                                .. "and h.type in (" .. tostring(ukm.header.sale) .. "," .. tostring(ukm.header.pop) .. ") "
                                .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                .. "and p.type = " .. tostring(ukm.payment.normal) .. " "
                                .. "and p.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                .. "and l.user_id = " .. ukm.to_mysql(iuv.id) .. ";";
                    local qry_user_sum_sale = ukm.query(__rep:get_conn(), text_select);
                    while qry_user_sum_sale:fetch() do
                        user_sum_sale = ukm.from_mysql.currency(qry_user_sum_sale:get_field(0));
                    end

                    text_select = "select ifnull(sum(p.amount), '0.00') from trm_out_shift_open so "
                                .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                .. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and h.cash_id = p.cash_id "
                                .. "inner join trm_out_login l on h.login = l.id and h.cash_id = l.cash_id "
                                .. "where so.number = " .. shift_number .. " "
                                .. "and h.type in (" .. tostring(ukm.header.sale) .. "," .. tostring(ukm.header.pop) .. ") "
                                .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                .. "and p.type = " .. tostring(ukm.payment.void) .. " "
                                .. "and p.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                .. "and l.user_id = " .. ukm.to_mysql(iuv.id) .. ";";
                    qry_user_sum_sale = ukm.query(__rep:get_conn(), text_select);
                    while qry_user_sum_sale:fetch() do
                        user_sum_sale = user_sum_sale - ukm.from_mysql.currency(qry_user_sum_sale:get_field(0));
                    end 
                    sum_sale = sum_sale + user_sum_sale;

                    local user_count_return = 0;

                    text_select = "select count(p.id) from trm_out_shift_open so "
                                .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                .. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and h.cash_id = p.cash_id "
                                .. "inner join trm_out_login l on h.login = l.id and h.cash_id = l.cash_id "
                                .. "where so.number = " .. shift_number .. " "
                                .. "and h.type in (" .. tostring(ukm.header.creturn) .. "," .. tostring(ukm.header.returnbyreceipt) .. ") "
                                .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                .. "and p.type = " .. tostring(ukm.payment.normal) .. " "
                                .. "and p.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                .. "and l.user_id = " .. ukm.to_mysql(iuv.id) .. ";";
                    local qry_user_count_return = ukm.query(__rep:get_conn(), text_select);
                    while qry_user_count_return:fetch() do
                        user_count_return = ukm.from_mysql.int(qry_user_count_return:get_field(0));
                    end 

                    text_select = "select count(p.id) from trm_out_shift_open so "
                                .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                .. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and h.cash_id = p.cash_id "
                                .. "inner join trm_out_login l on h.login = l.id and h.cash_id = l.cash_id "
                                .. "where so.number = " .. shift_number .. " "
                                .. "and h.type in (" .. tostring(ukm.header.creturn) .. "," .. tostring(ukm.header.returnbyreceipt) .. ") "
                                .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                .. "and p.type = " .. tostring(ukm.payment.void) .. " "
                                .. "and p.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                .. "and l.user_id = " .. ukm.to_mysql(iuv.id) .. ";";
                    qry_user_count_return = ukm.query(__rep:get_conn(), text_select);
                    while qry_user_count_return:fetch() do
                        user_count_return = user_count_return - ukm.from_mysql.int(qry_user_count_return:get_field(0));
                    end 

                    count_return = count_return + user_count_return;
                    local user_sum_return = ukm.currency(0);

                    text_select = "select ifnull(sum(p.amount), '0.00') from trm_out_shift_open so "
                                .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                .. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and h.cash_id = p.cash_id "
                                .. "inner join trm_out_login l on h.login = l.id and h.cash_id = l.cash_id "
                                .. "where so.number = " .. shift_number .. " "
                                .. "and h.type in (" .. tostring(ukm.header.creturn) .. "," .. tostring(ukm.header.returnbyreceipt) .. ") "
                                .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                .. "and p.type = " .. tostring(ukm.payment.normal) .. " "
                                .. "and p.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                .. "and l.user_id = " .. ukm.to_mysql(iuv.id) .. ";";
                    local qry_user_sum_return = ukm.query(__rep:get_conn(), text_select);
                    while qry_user_sum_return:fetch() do
                        user_sum_return = ukm.from_mysql.currency(qry_user_sum_return:get_field(0));
                    end 

                    text_select = "select ifnull(sum(p.amount), '0.00') from trm_out_shift_open so "
                                .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                .. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and h.cash_id = p.cash_id "
                                .. "inner join trm_out_login l on h.login = l.id and h.cash_id = l.cash_id "
                                .. "where so.number = " .. shift_number .. " "
                                .. "and h.type in (" .. tostring(ukm.header.creturn) .. "," .. tostring(ukm.header.returnbyreceipt) .. ") "
                                .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                .. "and p.type = " .. tostring(ukm.payment.void) .. " "
                                .. "and p.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
                                .. "and l.user_id = " .. ukm.to_mysql(iuv.id) .. ";";
                    qry_user_sum_return = ukm.query(__rep:get_conn(), text_select);
                    while qry_user_sum_return:fetch() do
                        user_sum_return = user_sum_return - ukm.from_mysql.currency(qry_user_sum_return:get_field(0));
                    end 

                    sum_return = sum_return + user_sum_return;
                    local user_profit = user_sum_sale - user_sum_return;
                    profit = profit + user_profit;

                    if width < 30 then
                        text = text .. ukm.adjustment("  ВНЕСЕНИЕ В КАССУ", tostring(user_count_insert),width-2, " ") .. "\n"
                                .. ukm.leftpad(tostring(user_sum_insert),width," ") .. "\n"
                                .. ukm.adjustment("  ИНКАССАЦИЯ", tostring(user_count_extract),width-2, " ") .. "\n"
                                .. ukm.leftpad(tostring(user_sum_extract),width," ") .. "\n"
                                .. ukm.adjustment("  ПРОДАЖА", tostring(user_count_sale),width-2, " ") .. "\n"
                                .. ukm.leftpad(tostring(user_sum_sale),width," ") .. "\n"
                                .. ukm.adjustment("  ВОЗВРАТ", tostring(user_count_return),width-2, " ") .. "\n"
                                .. ukm.leftpad(tostring(user_sum_return),width," ") .. "\n"
                                .. ukm.adjustment("  РЕАЛИЗАЦИЯ", tostring(user_profit),width, " ")  .. "\n";
                    else
                        text = text .. ukm.adjustment(ukm.adjustment(" ВНЕСЕНИЕ В КАССУ",tostring(total_count_insert),width-18, " "),to_str(total_sum_insert),width, " ") .. "\n"
                                    .. ukm.adjustment(ukm.adjustment("   ИНКАССАЦИЯ",tostring(user_count_extract),width-18, " "),to_str(user_sum_extract),width, " ") .. "\n"     
                                    .. ukm.adjustment(ukm.adjustment("   ПРОДАЖА",tostring(user_count_sale),width-18, " "),to_str(user_sum_sale),width, " ") .. "\n"                                        
                                    .. ukm.adjustment(ukm.adjustment("   ВОЗВРАТ",tostring(user_count_return),width-18, " "),to_str(user_sum_return),width, " ") .. "\n"                                        
                                    .. ukm.adjustment("   РЕАЛИЗАЦИЯ",to_str(user_profit),width, " ") .. "\n";
                    end
                end

                text = text .. " " .. "\n";
                text = text .. "ИТОГО " .. tostring(ipv.name) .. "\n";

                if width < 30 then
                    text = text .. ukm.adjustment(" ВНЕСЕНИЕ", tostring(count_insert),width-2, " ") .. "\n"
                        .. ukm.leftpad(tostring(sum_insert),width," ") .. "\n"
                        .. ukm.adjustment(" ИНКАССАЦИЯ", tostring(count_extract),width-2, " ") .. "\n"
                        .. ukm.leftpad(tostring(sum_extract),width," ") .. "\n"
                        .. ukm.adjustment(" ПРОДАЖА", tostring(count_sale),width-2, " ") .. "\n"
                        .. ukm.leftpad(tostring(sum_sale),width," ") .. "\n"
                        .. ukm.adjustment(" ВОЗВРАТ", tostring(count_return),width-2, " ") .. "\n"
                        .. ukm.leftpad(tostring(sum_return),width," ") .. "\n"
                        .. ukm.adjustment(" РЕАЛИЗАЦИЯ", tostring(profit),width, " ")  .. "\n";
                else
                  text = text .. ukm.adjustment(ukm.adjustment(" ВНЕСЕНИЕ",tostring(count_insert),width-18, " "),to_str(sum_insert),width, " ") .. "\n"
                                    .. ukm.adjustment(ukm.adjustment("   ИНКАССАЦИЯ",tostring(count_extract),width-18, " "),to_str(sum_extract),width, " ") .. "\n"     
                                    .. ukm.adjustment(ukm.adjustment("   ПРОДАЖА",tostring(count_sale),width-18, " "),to_str(sum_sale),width, " ") .. "\n"                                        
                                    .. ukm.adjustment(ukm.adjustment("   ВОЗВРАТ",tostring(count_return),width-18, " "),to_str(sum_return),width, " ") .. "\n"                                        
                                    .. ukm.adjustment("   РЕАЛИЗАЦИЯ",to_str(profit),width, " ") .. "\n";
                    end

                total_count_insert = total_count_insert + count_insert;
                total_sum_insert = total_sum_insert + sum_insert;
                total_count_extract = total_count_extract + count_extract;
                total_sum_extract = total_sum_extract + sum_extract
                total_count_sale = total_count_sale + count_sale;
                total_sum_sale = total_sum_sale + sum_sale;
                total_count_return = total_count_return + count_return;
                total_sum_return = total_sum_return + sum_return;
                total_profit = total_profit + profit;
                sum_cash_box = sum_cash_box + sum_insert - sum_extract + sum_sale - sum_return;
				local cur_efts = payments_table[ipk].efts;
				if(cur_efts == 2) then
                total_sum_cash_box = total_sum_cash_box + sum_cash_box;
				end

                text = text .. ukm.adjustment("СУММА В КАССЕ", to_str(sum_cash_box), width, " ") .. "\n \n";
            end

            text = text .. "ИТОГО ПО ВСЕМ ВИДАМ ОПЛАТ" .. "\n";

            if width < 30 then
                text = text .. ukm.adjustment(" ВНЕСЕНИЕ", tostring(total_count_insert),width-2, " ") .. "\n"
                    .. ukm.leftpad(to_str(total_sum_insert),width," ") .. "\n"
                    .. ukm.adjustment(" ИНКАССАЦИЯ", tostring(total_count_extract),width-2, " ")  .. "\n"
                    .. ukm.leftpad(to_str(total_sum_extract),width," ") .. "\n"
                    .. ukm.adjustment(" ПРОДАЖА", tostring(total_count_sale),width-2, " ") .. "\n"
                    .. ukm.leftpad(to_str(total_sum_sale),width," ") .. "\n"
                    .. ukm.adjustment(" ВОЗВРАТ", tostring(total_count_return),width-2, " ") .. "\n"
                    .. ukm.leftpad(to_str(total_sum_return),width," ") .. "\n"
                    .. ukm.adjustment(" РЕАЛИЗАЦИЯ", to_str(total_profit),width, " ")  .. "\n";
            else
                  text = text .. ukm.adjustment(ukm.adjustment(" ВНЕСЕНИЕ В КАССУ",tostring(total_count_insert),width-18, " "),to_str(total_sum_insert),width, " ") .. "\n"
                                    .. ukm.adjustment(ukm.adjustment("   ИНКАССАЦИЯ",tostring(total_count_extract),width-18, " "),to_str(total_sum_extract),width, " ") .. "\n"     
                                    .. ukm.adjustment(ukm.adjustment("   ПРОДАЖА",tostring(total_count_sale),width-18, " "),to_str(total_sum_sale),width, " ") .. "\n"                                        
                                    .. ukm.adjustment(ukm.adjustment("   ВОЗВРАТ",tostring(total_count_return),width-18, " "),to_str(total_sum_return),width, " ") .. "\n"                                        
                                    .. ukm.adjustment("   РЕАЛИЗАЦИЯ",to_str(total_profit),width, " ") .. "\n";

            end

            text = text .. " " .. "\nВ ДЕНЕЖНОМ ЯЩИКЕ ДОЛЖНО БЫТЬ:\n"
                .. ukm.leftpad(to_str(total_sum_cash_box), width, " ") .. "\n \n";

            __print_data:add(text, ukm.printer_type_master());

        end
    end
end

--Отчет по платежным средствам мультивалютный
function report_ext_payment_type_multi_currency(__rep, __print_data)
	local printer = ukm.get_printer(ukm.printer_type_master());
	if printer then
		local text = "";
		local width = printer:get_width();
		local shift_number = ukm.get_shift_number_from_user();
		if ukm.str_len(shift_number) ~= 0 then
			text = report_ext_general_header(__rep, width, shift_number) .. " " .. "\n"
				.. ukm.center("ОТЧЕТ ПО ПЛАТЕЖНЫМ", width, " ") .. "\n"
				.. ukm.center("СРЕДСТВАМ", width, " ") .. "\n"
				.. " " .. "\n"
				.. ukm.adjustment("СР-ВО/ОПЕРАЦИЯ  К-ВО","СУММА",width, " ") .. "\n"
				.. " " .. "\n";

			local text_select = "";

			local before_shift_id = "0";

			text_select = "select id from trm_out_shift_open where cash_id = " .. tostring(ukm.get_cash_id()) .. " "
						.. "and number < " .. shift_number .. " "
						.. "order by id desc "
						.. "limit 1";
			local qry_before_shift_id = ukm.query(__rep:get_conn(), text_select);
			if qry_before_shift_id:fetch() then
				before_shift_id = ukm.from_mysql.string(qry_before_shift_id:get_field(0));
			end

			text_select = "select p.payment_id, p.payment_name from trm_out_shift_open so "
						.. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
						.. "inner join trm_out_receipt_footer f on h.id = f.id and f.cash_id = h.cash_id "
						.. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and p.cash_id = h.cash_id "
						.. "where so.number = " .. shift_number .. " "
						.. "and h.type in (" .. tostring(ukm.header.sale) .. "," .. tostring(ukm.header.creturn) .. "," .. tostring(ukm.header.returnbyreceipt) .. "," .. tostring(ukm.header.pop) .. ") "
						.. "and f.result = " .. tostring(ukm.footer.normal) .. " "
						.. "and p.type = " .. tostring(ukm.payment.normal) .. " "
						.. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
						.. "group by p.payment_id "
						.. "union "
						.. "select m.payment_id, m.payment_name from trm_out_moneyoperation m "
						.. "where m.shift_number = " ..  shift_number .. " "
						.. "and m.type in (" .. tostring(ukm.moneyoperation.insert) .. "," .. tostring(ukm.moneyoperation.extract) .. ") "
						.. "and m.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
						.. "group by m.payment_id ";

			local qry_payments = ukm.query(__rep:get_conn(), text_select);
			payments_table = {}; 
			payments_change = {};
			while qry_payments:fetch() do
				local p_id = ukm.from_mysql.int(qry_payments:get_field(0));
				local p_name = ukm.from_mysql.string(qry_payments:get_field(1));
				payments_table[p_id] = {};
				payments_table[p_id].id = p_id;
				payments_table[p_id].name = p_name;
				payments_change[p_id] = {};
				payments_change[p_id].change = "0";
				payments_change[p_id].change_base = "0";
				
			end 


			for ipk, ipv in pairs(payments_table) do

				local currency_id = ukm.get_store_payment_currency_id(ipv.id);
				text_select = "select shortname from trm_in_currency  "
								.. "where global_id = 0 and currency_id = " ..  tostring(currency_id) .. ";";
				local currency_name = "";
				local qry_currency_name = ukm.query(__rep:get_conn(), text_select);
				while qry_currency_name:fetch() do
					currency_name = ukm.from_mysql.string(qry_currency_name:get_field(0));   
				end
				

				text = text .. ukm.adjustment(tostring(ipv.name), "(" .. currency_name ..")", width, " ") .. "\n";


				local count_insert = 0;
				local sum_insert = ukm.currency(0);
				local count_extract = 0;
				local sum_extract = ukm.currency(0);
				local count_sale = 0;
				local sum_sale = ukm.currency(0);
				local count_return = 0;
				local sum_return = ukm.currency(0);
				local profit = ukm.currency(0);
				local change_currency = ukm.currency(0);
				local change_base = ukm.currency(0);
				

 
				text_select = "select count(id) from trm_out_moneyoperation "
								.. "where shift_number = " ..  shift_number .. " "
								.. "and type = " .. tostring(ukm.moneyoperation.insert) .. " "
								.. "and payment_id = " .. ukm.to_mysql(ipv.id) .. " "
								.. "and cash_id = " .. tostring(ukm.get_cash_id()) .. ";";
				local qry_count_insert= ukm.query(__rep:get_conn(), text_select);

				while qry_count_insert:fetch() do
					count_insert = ukm.from_mysql.int(qry_count_insert:get_field(0));   
				end

				
				text_select = "select ifnull(sum(amount), '0.00') from trm_out_moneyoperation  "
								.. "where shift_number = " ..  shift_number .. " "
								.. "and type = " .. tostring(ukm.moneyoperation.insert) .. " "
								.. "and payment_id = " .. ukm.to_mysql(ipv.id) .. " "
								.. "and cash_id = " .. tostring(ukm.get_cash_id()) .. ";";
				local qry_sum_insert= ukm.query(__rep:get_conn(), text_select);

				while qry_sum_insert:fetch() do
					sum_insert = ukm.from_mysql.currency(qry_sum_insert:get_field(0));   
                end

				text_select = "select count(id) from trm_out_moneyoperation "
                                .. "where shift_number = " ..  shift_number .. " "
                                .. "and type = " .. tostring(ukm.moneyoperation.extract) .. " "
                                .. "and payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and cash_id = " .. tostring(ukm.get_cash_id()) .. ";";
                local qry_count_extract= ukm.query(__rep:get_conn(), text_select);

                while qry_count_extract:fetch() do
                    count_extract = ukm.from_mysql.int(qry_count_extract:get_field(0));   
                end
                
				text_select = "select ifnull(sum(amount), '0.00') from trm_out_moneyoperation "
                                .. "where shift_number = " ..  shift_number .. " "
                                .. "and type = " .. tostring(ukm.moneyoperation.extract) .. " "
                                .. "and payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and cash_id = " .. tostring(ukm.get_cash_id()) .. ";";
                local qry_sum_extract = ukm.query(__rep:get_conn(), text_select);
                while qry_sum_extract:fetch() do
                    sum_extract= ukm.from_mysql.currency(qry_sum_extract:get_field(0));   
                end                   

                text_select = "select count(p.id) from trm_out_shift_open so "
                                .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                .. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and h.cash_id = p.cash_id "
                                .. "where so.number = " .. shift_number .. " "
                                .. "and h.type in (" .. tostring(ukm.header.sale) .. "," .. tostring(ukm.header.pop) .. ") "
                                .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                .. "and p.type = " .. tostring(ukm.payment.normal) .. " "
                                .. "and p.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. ";";
                local qry_count_sale = ukm.query(__rep:get_conn(), text_select);
                while qry_count_sale:fetch() do
					count_sale = ukm.from_mysql.int(qry_count_sale:get_field(0));
                end 

                text_select = "select count(p.id) from trm_out_shift_open so "
                                .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                .. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and h.cash_id = p.cash_id "
                                .. "where so.number = " .. shift_number .. " "
                                .. "and h.type in (" .. tostring(ukm.header.sale) .. "," .. tostring(ukm.header.pop) .. ") "
                                .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                .. "and p.type = " .. tostring(ukm.payment.void) .. " "
                                .. "and p.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. ";";
                qry_count_sale = ukm.query(__rep:get_conn(), text_select);
                while qry_count_sale:fetch() do
                    count_sale = count_sale - ukm.from_mysql.int(qry_count_sale:get_field(0));
                end

                text_select = "select ifnull(sum(p.amount), '0.00'), ifnull(sum(pc.amount), '0.00'), ifnull(sum(pc.amount_with_change - pc.amount), '0.00'), ifnull(sum(p.amount_with_change - p.amount), '0.00') from trm_out_shift_open so "
                                .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                .. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and h.cash_id = p.cash_id "
								.. "left join trm_out_receipt_payment_currency pc on pc.cash_id = p.cash_id and pc.id = p.id "
                                .. "where so.number = " .. shift_number .. " "
                                .. "and h.type in (" .. tostring(ukm.header.sale) .. "," .. tostring(ukm.header.pop) .. ") "
                                .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                .. "and p.type = " .. tostring(ukm.payment.normal) .. " "
                                .. "and p.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. ";";
                local qry_sum_sale = ukm.query(__rep:get_conn(), text_select);
                while qry_sum_sale:fetch() do
					  local sum_sale_local_currency = ukm.from_mysql.currency(qry_sum_sale:get_field(1));
					  if(tostring(sum_sale_local_currency) ~= "0.00") then
						sum_sale = sum_sale_local_currency;
						change_currency =  ukm.from_mysql.currency(qry_sum_sale:get_field(2));
						change_base = ukm.from_mysql.currency(qry_sum_sale:get_field(3));
						payments_change[ipv.id].change = tostring(change_currency);
						payments_change[ipv.id].change_base = tostring(change_base);
					  else
						sum_sale = ukm.from_mysql.currency(qry_sum_sale:get_field(0));
						payments_change[ipv.id].change = "0";
					  end
                end

                text_select = "select ifnull(sum(p.amount), '0.00'), ifnull(sum(pc.amount), '0.00'), ifnull(sum(pc.amount_with_change - pc.amount), '0.00'), ifnull(sum(pc.amount_with_change - pc.amount), '0.00') from trm_out_shift_open so "
                                .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                .. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and h.cash_id = p.cash_id "
								.. "left join trm_out_receipt_payment_currency pc on pc.cash_id = p.cash_id and pc.id = p.id "
                                .. "where so.number = " .. shift_number .. " "
                                .. "and h.type in (" .. tostring(ukm.header.sale) .. "," .. tostring(ukm.header.pop) .. ") "
                                .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                .. "and p.type = " .. tostring(ukm.payment.void) .. " "
                                .. "and p.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. ";";
                qry_sum_sale = ukm.query(__rep:get_conn(), text_select);
                while qry_sum_sale:fetch() do
					local sale_void_currency = ukm.from_mysql.currency(qry_sum_sale:get_field(1));
					if(tostring(sale_void_currency) ~= "0.00") then
						sum_sale = sum_sale - sale_void_currency;
						change_currency = change_currency - ukm.from_mysql.currency(qry_sum_sale:get_field(2));
						change_base = change_base - ukm.from_mysql.currency(qry_sum_sale:get_field(3));
						payments_change[ipv.id].change = tostring(change_currency); 
						payments_change[ipv.id].change_base = tostring(change_base); 
					else
						sum_sale = sum_sale - ukm.from_mysql.currency(qry_sum_sale:get_field(0));
					end
                end 

                text_select = "select count(p.id) from trm_out_shift_open so "
                                .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                .. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and h.cash_id = p.cash_id "
                                .. "where so.number = " .. shift_number .. " "
                                .. "and h.type in (" .. tostring(ukm.header.creturn) .. "," .. tostring(ukm.header.returnbyreceipt) .. ") "
                                .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                .. "and p.type = " .. tostring(ukm.payment.normal) .. " "
                                .. "and p.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. ";";
                local qry_count_return = ukm.query(__rep:get_conn(), text_select);
                while qry_count_return:fetch() do
                    count_return = ukm.from_mysql.int(qry_count_return:get_field(0));
                end 

                text_select = "select count(p.id) from trm_out_shift_open so "
                                .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                .. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and h.cash_id = p.cash_id "
                                .. "where so.number = " .. shift_number .. " "
                                .. "and h.type in (" .. tostring(ukm.header.creturn) .. "," .. tostring(ukm.header.returnbyreceipt) .. ") "
                                .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                .. "and p.type = " .. tostring(ukm.payment.void) .. " "
                                .. "and p.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. ";";
                qry_count_return = ukm.query(__rep:get_conn(), text_select);
                while qry_count_return:fetch() do
                    count_return = count_return - ukm.from_mysql.int(qry_count_return:get_field(0));
                end 

                
                text_select = "select ifnull(sum(p.amount), '0.00'), ifnull(sum(pc.amount), '0.00') from trm_out_shift_open so "
                                .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                .. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and h.cash_id = p.cash_id "
								.. "left join trm_out_receipt_payment_currency pc on pc.cash_id = p.cash_id and pc.id = p.id "
                                .. "where so.number = " .. shift_number .. " "
                                .. "and h.type in (" .. tostring(ukm.header.creturn) .. "," .. tostring(ukm.header.returnbyreceipt) .. ") "
                                .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                .. "and p.type = " .. tostring(ukm.payment.normal) .. " "
                                .. "and p.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. ";";
                local qry_sum_return = ukm.query(__rep:get_conn(), text_select);
                while qry_sum_return:fetch() do
					local sum_return_local_currency = ukm.from_mysql.currency(qry_sum_return:get_field(1));
					if(tostring(sum_return_local_currency) ~= "0.00") then
						sum_return = sum_return_local_currency;
					else
						sum_return = ukm.from_mysql.currency(qry_sum_return:get_field(0));
					end
                end 

                text_select = "select ifnull(sum(p.amount), '0.00'), ifnull(sum(pc.amount), '0.00') from trm_out_shift_open so "
                                .. "inner join trm_out_receipt_header h on so.id = h.shift_open and so.cash_id = h.cash_id "
                                .. "inner join trm_out_receipt_footer f on h.id = f.id and h.cash_id = f.cash_id "
                                .. "inner join trm_out_receipt_payment p on h.id = p.receipt_header and h.cash_id = p.cash_id "
								.. "left join trm_out_receipt_payment_currency pc on pc.cash_id = p.cash_id and pc.id = p.id "
                                .. "where so.number = " .. shift_number .. " "
                                .. "and h.type in (" .. tostring(ukm.header.creturn) .. "," .. tostring(ukm.header.returnbyreceipt) .. ") "
                                .. "and f.result = " .. tostring(ukm.footer.normal) .. " "
                                .. "and p.type = " .. tostring(ukm.payment.void) .. " "
                                .. "and p.payment_id = " .. ukm.to_mysql(ipv.id) .. " "
                                .. "and so.cash_id = " .. tostring(ukm.get_cash_id()) .. ";";
                qry_sum_return = ukm.query(__rep:get_conn(), text_select);
                while qry_sum_return:fetch() do
					local sum_return_void_currency = ukm.from_mysql.currency(qry_sum_return:get_field(1));
					if(tostring(sum_return_void_currency) ~= "0.00") then
						sum_return = sum_return - sum_return_void_currency;
					else
						sum_return = sum_return - ukm.from_mysql.currency(qry_sum_return:get_field(0));
					end
                end 

                profit = sum_sale - sum_return;
 
                if width < 30 then
                        text = text .. ukm.adjustment("  ВНЕСЕНИЕ", tostring(count_insert),width-2, " ") .. "\n"
                                .. ukm.leftpad(tostring(sum_insert),width," ") .. "\n"
                                .. ukm.adjustment("  ИНКАССАЦИЯ", tostring(count_extract),width-2, " ") .. "\n"
                                .. ukm.leftpad(tostring(sum_extract),width," ") .. "\n"
                                .. ukm.adjustment("  ПРОДАЖА", tostring(count_sale),width-2, " ") .. "\n"
                                .. ukm.leftpad(tostring(sum_sale),width," ") .. "\n"
                                .. ukm.adjustment("  ВОЗВРАТ", tostring(count_return),width-2, " ") .. "\n"
                                .. ukm.leftpad(tostring(sum_return),width," ") .. "\n"
                                .. ukm.adjustment("  РЕАЛИЗАЦИЯ", tostring(profit),width, " ")  .. "\n";
                else
                        text = text .. ukm.adjustment(ukm.adjustment("   ВНЕСЕНИЕ",tostring(count_insert),width-18, " "),tostring(sum_insert),width, " ") .. "\n"
                                    .. ukm.adjustment(ukm.adjustment("   ИНКАССАЦИЯ",tostring(count_extract),width-18, " "),tostring(sum_extract),width, " ") .. "\n"     
                                    .. ukm.adjustment(ukm.adjustment("   ПРОДАЖА",tostring(count_sale),width-18, " "),tostring(sum_sale),width, " ") .. "\n"                                        
                                    .. ukm.adjustment(ukm.adjustment("   ВОЗВРАТ",tostring(count_return),width-18, " "),tostring(sum_return),width, " ") .. "\n"                                        
                                    .. ukm.adjustment("   РЕАЛИЗАЦИЯ",tostring(profit),width, " ") .. "\n";
                end
				
				text = text .. " " .. "\n";
				
            end

			local base_currency_name = "";
			local text_convert = "";
			currency_id = ukm.get_store().currency_id;
			text_select = "select shortname from trm_in_currency  "
						.. "where global_id = 0 and currency_id = " ..  tostring(currency_id) .. ";";
			qry_currency_name = ukm.query(__rep:get_conn(), text_select);
					
			while qry_currency_name:fetch() do
				base_currency_name = ukm.from_mysql.string(qry_currency_name:get_field(0));   
			end				
			
			for ipk, ipv in pairs(payments_change) do
				if( tostring(ipv.change) ~= "0" ) then
					currency_id = ukm.get_store_payment_currency_id(ipk);
					text_select = "select shortname from trm_in_currency  "
									.. "where global_id = 0 and currency_id = " ..  tostring(currency_id) .. ";";
					currency_name = "";
					qry_currency_name = ukm.query(__rep:get_conn(), text_select);
					
					while qry_currency_name:fetch() do
						currency_name = ukm.from_mysql.string(qry_currency_name:get_field(0));   
					end	
					
					text_convert =  text_convert .. "   " .. tostring(ipv.change) .. " " .. currency_name .. " = " .. tostring(ipv.change_base) .. " " .. base_currency_name .. "\n";
				end
			end
			
			if text_convert ~= "" then
				text = text .. " " .. "\nКОНВЕРТИРОВАНО В ВИДЕ СДАЧИ:\n"
				text = text .. text_convert .. "\n";
			end
			
			local shift_close_id = "0";
			
			text_select = "SELECT so.id FROM trm_out_shift_open so "
						.. "INNER JOIN trm_out_shift_close sc ON so.cash_id = sc.cash_id AND so.id = sc.id "
						.. "where so.cash_id = " .. tostring(ukm.get_cash_id()) .. " "
						.. "and so.number = " .. shift_number .. ";";
			local qry_close_shift_id = ukm.query(__rep:get_conn(), text_select);
			if qry_close_shift_id:fetch() then
				shift_close_id = ukm.from_mysql.string(qry_close_shift_id:get_field(0));
			end

			if shift_close_id == "0" then
			
				text = text .. " " .. "\nВ ДЕНЕЖНОМ ЯЩИКЕ ДОЛЖНО БЫТЬ:\n"
				
				text_select = "select payment, ifnull(sum(amount),'0.00') from trm_auth_local_storage "
							.. "where deleted = 0 "
							.. "group by cash_id, payment" .. ";";
				local qry_sum_cashdrawer = ukm.query(__rep:get_conn(), text_select);
				cash_payments_table = {}; 
				while qry_sum_cashdrawer:fetch() do
					local cash_p_id = ukm.from_mysql.int(qry_sum_cashdrawer:get_field(0));
					local cash_p_sum = ukm.from_mysql.currency(qry_sum_cashdrawer:get_field(1));
					cash_payments_table[cash_p_id] = {};
					cash_payments_table[cash_p_id].id = cash_p_id;
					cash_payments_table[cash_p_id].sum = cash_p_sum; 
				end 
		
                                local lp_count = 0;

				for ipk, ipv in pairs(cash_payments_table) do
					currency_id = ukm.get_store_payment_currency_id(ipv.id);
					text_select = "select shortname from trm_in_currency  "
									.. "where global_id = 0 and currency_id = " ..  tostring(currency_id) .. ";";
					currency_name = "";
					qry_currency_name = ukm.query(__rep:get_conn(), text_select);
					
					while qry_currency_name:fetch() do
						currency_name = ukm.from_mysql.string(qry_currency_name:get_field(0));   
					end	
					
					text = text .. ukm.adjustment(currency_name,tostring(ipv.sum),width, " ") .. "\n";
                                        
                                        lp_count = lp_count + 1;
				end
                                
                                if(lp_count == 0) then
                                        text = text .. "  " .. "ПУСТО\n";
                                end;

			end

            __print_data:add(text, ukm.printer_type_master());

        end
    end
end
function select_receipts(__rtype, __shift, __cash_id, __wholesale)
	local text_select = "SELECT o.ext_order_id, rs.amount, h.local_number "
		.. "FROM `trm_out_receipt_external_orders` o "
		.. "INNER JOIN `trm_out_receipt_header` h ON o.cash_id = h.cash_id AND o.id = h.id AND (h.type = " .. __rtype
		.. " INNER JOIN trm_in_pos p ON h.cash_id = p.cash_id "
		.. "INNER JOIN trm_out_receipt_subtotal rs ON h.cash_id = rs.cash_id AND rs.id = h.id AND rs.deleted = 0 "
		.. "INNER JOIN trm_out_receipt_footer f ON f.cash_id = rs.cash_id AND f.id = h.id AND f.deleted = 0 AND f.result = 0 "
		.. "WHERE h.shift_open = " .. __shift .. " AND o.wholesale = " .. __wholesale .. " AND o.cash_id = " .. __cash_id
		.. " ORDER BY h.local_number";

	return text_select;
end

function report_paid_orders(__rep, __print_data)
-- Запросили номер смены
	local shift_number = ukm.get_shift_number_from_user();

	if ukm.str_len(shift_number) ~= 0 then
		local printer = ukm.get_printer(ukm.printer_type_master());
		if printer then
			local text = "";
			local width = printer:get_width();

			text = report_ext_general_header(__rep, width, shift_number);
			local text_select;
			local cash_id = ukm.get_cash_id();

			text = text .. ukm.center("ОТЧЁТ ПО ОПЛАЧЕННЫМ ЗАКАЗАМ", width, " ") .. "\n\n";
			text = text .. ukm.center("Мелкооптовые заказы", width, " ") .. "\n";
			text = text .. ukm.adjustment("Номер заказа           Чек", "Сумма", width, " ") .. "\n";
-- выбираем
			text_select = select_receipts("0 OR h.type = 5) ", shift_number, cash_id, 1);
			local u_total_amount = ukm.currency(0);
			local u_count = 0;

			local qry_wholesale = ukm.query(__rep:get_conn(), text_select);
--результаты запроса помещаем сразу в text
			while qry_wholesale:fetch() do
				local u_num = ukm.from_mysql.string(qry_wholesale:get_field(0));
				if ukm.str_len(u_num) > 13 then
					u_num = ukm.left(u_num, 4) .. "**" .. ukm.right(u_num, 8);
				end
				local u_receipt_number = ukm.from_mysql.string(qry_wholesale:get_field(2));
				local u_total = ukm.from_mysql.currency(qry_wholesale:get_field(1));
				u_total_amount = u_total_amount + u_total;
				u_count = u_count + 1;

				text = text .. ukm.adjustment(ukm.rightpad(u_num, 15, " ") .. 
					ukm.leftpad(tostring(ukm.get_pos_number()) .. "." .. shift_number .. "." .. u_receipt_number, 12, " "),
					tostring(u_total), width, " ") .. "\n";
			end

			text = text .. "\n" .. "ИТОГО по мелкооптовым заказам" .. "\n";

			text = text .. "Кол-во заказов - " .. tostring(u_count) .. "\n";
			text = text .. "Сумма - " .. tostring(u_total_amount) .. "\n\n";
-- возвраты
			text = text .. "Bозвраты" .. "\n";
			text = text .. ukm.adjustment("Номер заказа           Чек", "Сумма", width, " ") .. "\n";
			text_select = select_receipts("4)", shift_number, cash_id, 1);

			local u_total_amount_return = ukm.currency(0);
			local u_count_return = 0;
			local qry_wholesale_return = ukm.query(__rep:get_conn(), text_select);

			while qry_wholesale_return:fetch() do
				local u_num = ukm.from_mysql.string(qry_wholesale_return:get_field(0));
				if ukm.str_len(u_num) > 13 then
					u_num = ukm.left(u_num, 4) .. "**" .. ukm.right(u_num, 8);
				end
				local u_receipt_number = ukm.from_mysql.string(qry_wholesale_return:get_field(2));
				local u_total = ukm.from_mysql.currency(qry_wholesale_return:get_field(1));
				u_total_amount_return = u_total_amount_return + u_total;
				u_count_return = u_count_return + 1;
				text = text .. ukm.adjustment(ukm.rightpad(u_num, 15, " ") .. 
					ukm.leftpad(tostring(ukm.get_pos_number()) .. "." .. shift_number .. "." .. u_receipt_number, 12, " "),
					tostring(u_total), width, " ") .. "\n";
			end

			text = text .. "\n" .. "ИТОГО по возвратам" .. "\n";

			text = text .. "Кол-во заказов - " .. tostring(u_count_return) .. "\n";
			text = text .. "Сумма - " .. tostring(u_total_amount_return) .. "\n\n";

			text = text .. ukm.rightpad("-",width,"-") .. "\n";

			text = text .. ukm.center("Розничные заказы", width, " ") .. "\n";
			text = text .. ukm.adjustment("Номер заказа           Чек", "Сумма", width, " ") .. "\n";

			text_select = select_receipts("0 OR h.type = 5) ", shift_number, cash_id, 0);

			local u_count1 = 0;
			local u_total_amount1 = ukm.currency(0);
			local qry_sale = ukm.query(__rep:get_conn(), text_select);

			while qry_sale:fetch() do
				local u_num = ukm.from_mysql.string(qry_sale:get_field(0));
				if ukm.str_len(u_num) > 13 then
					u_num = ukm.left(u_num, 4) .. "**" .. ukm.right(u_num, 8);
				end
				local u_receipt_number = ukm.from_mysql.string(qry_sale:get_field(2));
				local u_total = ukm.from_mysql.currency(qry_sale:get_field(1));
				u_count1 = u_count1 + 1;
				u_total_amount1 = u_total_amount1 + u_total;

				text = text .. ukm.adjustment(ukm.rightpad(u_num, 15, " ") .. 
					ukm.leftpad(tostring(ukm.get_pos_number()) .. "." .. shift_number .. "." .. u_receipt_number, 12, " "),
					tostring(u_total), width, " ") .. "\n";
			end

			text = text .. "\n" .. "ИТОГО по розничным заказам" .. "\n";

			text = text .. "Кол-во заказов - " .. tostring(u_count1) .. "\n";
			text = text .. "Сумма - " .. tostring(u_total_amount1) .. "\n\n";
			text = text .. "Возвраты" .. "\n";
			text = text .. ukm.adjustment("Номер заказа           Чек", "Сумма", width, " ") .. "\n";

			text_select = select_receipts("4)", shift_number, cash_id, 0);

			local u_count1_return = 0;
			local u_total_amount1_return = ukm.currency(0);
			local qry_return = ukm.query(__rep:get_conn(), text_select);

			while qry_return:fetch() do
				local u_num = ukm.from_mysql.string(qry_return:get_field(0));
				if ukm.str_len(u_num) > 13 then
					u_num = ukm.left(u_num, 4) .. "**" .. ukm.right(u_num, 8);
				end
				local u_receipt_number = ukm.from_mysql.string(qry_return:get_field(2));
				local u_total = ukm.from_mysql.currency(qry_return:get_field(1));
				u_count1_return = u_count1_return + 1;
				u_total_amount1_return = u_total_amount1_return + u_total;

				text = text .. ukm.adjustment(ukm.rightpad(u_num, 15, " ") .. 
					ukm.leftpad(tostring(ukm.get_pos_number()) .. "." .. shift_number .. "." .. u_receipt_number, 12, " "),
					tostring(u_total), width, " ") .. "\n";
			end

			text = text .. "\n" .. "ИТОГО по возвратам" .. "\n";
			text = text .. "Кол-во заказов - " .. tostring(u_count1_return) .. "\n";
			text = text .. "Сумма - " .. tostring(u_total_amount1_return) .. "\n\n";

			text = text .. ukm.rightpad("-",width,"-") .. "\n";

			text = text .. "ИТОГО по всем заказам" .. "\n";
			text = text .. "Кол-во заказов - " .. tostring(u_count + u_count1) .. "\n";
			text = text .. "Сумма - " .. tostring(u_total_amount + u_total_amount1 - (u_total_amount_return + u_total_amount1_return)) .. "\n\n";

			__print_data:add(text, ukm.printer_type_master());
		end
	end
end
