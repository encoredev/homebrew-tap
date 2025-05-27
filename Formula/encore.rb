class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.48.0"
    checksums = {
        "darwin_arm64" => "1c3166a10a30db1f6b31d9db99e8773a47fd8b933e7ada97db47495408880d99",
        "darwin_amd64" => "8bebc1e7fb6a3c2a999da50bfc12bcdf59fc7b6799a5c8b8c34f6c1773520f08",
        "linux_arm64"  => "5b039d66d3a6080d79c55082f9f8be31466ed63ef7257c5a2f7b6e13033bcbc3",
        "linux_amd64"  => "b129ccb6b4f4a1215d98a0a5ab7c23c676d0f5ff78a821e01a65decc9d483f56",
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
