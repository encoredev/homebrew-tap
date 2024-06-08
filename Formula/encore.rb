class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.38.7"
    checksums = {
        "darwin_arm64" => "85761cb96a7efec8c0cc70bdc6ce1d396a04a4cdeaf51874f8abfc938582ca7a",
        "darwin_amd64" => "0bff7f5ce666390d8802c78d589e78880ceb017393bf21d5f6d30cdec4134399",
        "linux_arm64"  => "1bd0c4c6b77dc428956eda42b60bc58c9759d9b6cad9ae6a044463aeb9115e3a",
        "linux_amd64"  => "771f9d5ba980353b5bf5590964f080b5446711bc35a551b199d6352815ccd83e",
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
