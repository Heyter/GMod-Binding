bind = { Bindings = {} }

function bind.Add( key, name, func )

	if !isfunction( func ) then return end
	if !isnumber( key ) then return end

	if bind.Bindings[ key ] == nil then
		bind.Bindings[ key ] = {}
	end

	bind.Bindings[ key ][ name ] = func

end

function bind.Remove( key, name )

	if !isnumber( key ) then return end
	if !bind.Bindings[ key ] then return end

	bind.Bindings[ key ][ name ] = nil

end

local FirstPressed = {}

hook.Add( "Tick", "CallBindings", function()
	for key, tbl in pairs( bind.Bindings ) do
		if input.IsButtonDown( key ) then
			if FirstPressed[ key ] then
				for _, func in pairs( tbl ) do func() end
				FirstPressed[ key ] = false
			end
		else
			FirstPressed[ key ] = true
		end
	end
end )
