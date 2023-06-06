class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230606"
    checksums = {
        "darwin_arm64" => "c3161a18975c929a82420aa30dbd7a62d96a0445f69d85824e312ded8421812f",
        "darwin_amd64" => "6451f33f2996fed8991709eccd648f7556a28bb105d1661bad5bf602cf8b9ebc",
        "linux_arm64"  => "1a0b75a2ff1df276959167a785aeba33a3a421ad4c9efbd75ef6f1765227f6bf",
        "linux_amd64"  => "66dc5caa4620ed4b00605b65a1db11423c34d1135437b28750108f71c4b5a998",
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
