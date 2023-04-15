class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.15.0"
    checksums = {
        "darwin_arm64" => "8b3bd92e4e408f14aba9167fe687c4549962e9badba56c229ffc757349fe99a7",
        "darwin_amd64" => "f641fa2eb3911a96b7543d4801770bacaa2eeb99522deb674b215c54d3102861",
        "linux_arm64"  => "c59d7f53ef3b1353a179ab64931037ab32843d6e3304457a1af7b776df624313",
        "linux_amd64"  => "f85be77e2d3425c0779fc0ebd012f1359ac2e4eefea956dcc2b1032b44f8933a",
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
