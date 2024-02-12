
TTree* GetTree(TFile *file, TString treeName) {
    TTree *tree = nullptr;
    file->GetObject(treeName, tree);
    return tree;
}

TTree* GetTree(TString treeName, TFile *file) {
    TTree *tree = nullptr;
    file->GetObject(treeName, tree);
    return tree;
}
