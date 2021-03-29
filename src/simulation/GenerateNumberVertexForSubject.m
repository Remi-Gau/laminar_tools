function Opt = GenerateNumberVertexForSubject(Opt)

    Opt.NbVertices = round(Opt.NbVerticesRange(1) + ...
                           rand(Opt.NbSubject, 1) * diff(Opt.NbVerticesRange));

end
