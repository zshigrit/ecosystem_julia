## create dataframe to store output 

function create_dataframe(FT,ncycle,nyear)#(FT,weather::DataFrame)
    
    df    = DataFrame();
   
    df[!, "Time"  ] = zeros(ncycle*nyear*365);
    df[!, "POMh" ] .= FT(0);
    df[!, "POMo" ] .= FT(0);
    df[!, "MOM"  ] .= FT(0);
    df[!, "DOM"  ] .= FT(0);
    df[!, "QOM"    ] .= FT(0);

    
    df[!, "MBA"   ] .= FT(0);
    df[!, "MBD"] .= FT(0);

    return df
end

function create_dataframe(FT,nlayer)#(FT,weather::DataFrame)
    
    df    = DataFrame();
   
    df[!, "Layer"  ] = zeros(nlayer+1);
    df[!, "POMh" ] .= FT(0);
    df[!, "POMo" ] .= FT(0);
    df[!, "MOM"  ] .= FT(0);
    df[!, "DOM"  ] .= FT(0);
    df[!, "QOM"  ] .= FT(0);

    
    df[!, "MBA"] .= FT(0);
    df[!, "MBD"] .= FT(0);

    return df
end