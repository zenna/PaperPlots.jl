using Documenter, PaperPlots

makedocs(;
    modules=[PaperPlots],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/zenna/PaperPlots.jl/blob/{commit}{path}#L{line}",
    sitename="PaperPlots.jl",
    authors="Zenna Tavares",
    assets=String[],
)

deploydocs(;
    repo="github.com/zenna/PaperPlots.jl",
)
