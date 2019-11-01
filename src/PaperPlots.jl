module PaperPlots
using Plots, Measures
using Plots: PGFPlotsBackend, PyPlotBackend, GRBackend
export PGFPlotsBackend, PyPlotBackend, GRBackend
export linewidth, textwidth, scalefont, allfontsizes

export SIGPLAN

const Backend = Union{PGFPlotsBackend, PyPlotBackend, GRBackend}

include("templates.jl")

"""
Return the font size to pass to `plot` for a target font size in
the rendered pdf of 

`scalefont(8, PGFPlotsBackend; width_phys = linewidth(SIGPLAN), dpi = 300)``

# Arguments 
size_px : Size of the image in pixels, (i.e. size argument of Plots)
size_phy : size in 
"""
function scalefont(fontsize; width_px = 800, width_phys, dpi = 100, scale)
  @show unit_width = (width_px / dpi) * inch
  @show rel_width = unit_width / width_phys
  @show fsz = fontsize * rel_width * scale
  Int(round(fsz))
end 

scalefont(fontsize, ::Type{B}; width_px = 800, width_phys, dpi = dpi(B)) where {B <: Backend} = 
  scalefont(fontsize; width_px = width_px, width_phys = width_phys, dpi = dpi, scale = scale(B))

""""From a small font size generate a named tuple for everything"""
function fromfontsm(fntsm; scale = 1.4)
  fntlg = Int(round(fntsm * scale))
  (titlefontsize = fntlg, guidefontsize = fntlg, tickfontsize = fntsm, legendfontsize = fntsm)
end

"""

`allfontsizes(SIGPLAN, PGFPlotsBackend; dpi = 300`
"""
function allfontsizes(venue, backend::Type; scale = 1.4, width_phys = linewidth(venue), fntsm = defaultsm(venue), kwargs...)
  fntsm_rc = scalefont(fntsm, backend; width_phys = width_phys, kwargs...)
  fromfontsm(fntsm_rc; scale = scale)
end

end