class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.36.0"
    checksums = {
        "darwin_arm64" => "d930255d341837a3a86d32c8f41a63449773761f2399b815d7744ba260ce06c3",
        "darwin_amd64" => "889f6d735bd4320da83a9cb4928b9cc1d61712ff91516a87688a75a05fb01ecb",
        "linux_arm64"  => "51c107596810389c6575c9801528c0aa42eb50d8028a6848bc00a7a37c2018b3",
        "linux_amd64"  => "e46ef7679f1b9390c2d8af687cc362edc91efe1b8aba01cbb6fe1ed0b7ea352a",
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
