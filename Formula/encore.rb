class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.41.10"
    checksums = {
        "darwin_arm64" => "50f656275a7f995fae6cd636481d9574d2978a5e53c4cdc6228c11e9bc5137c4",
        "darwin_amd64" => "863c0e63faff5e9690972686e8891e72820355648b0e3f1e0c6c21e8350672d6",
        "linux_arm64"  => "520a253c9201eabef668ffaab6e0d7b5a53e80056af46b96538aeda1784c68ff",
        "linux_amd64"  => "60bcc5ab4554f85701d805dd69fe80877b5c3fedcdd25546aac3635c49418abd",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink Dir[libexec/"bin/*"]


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
